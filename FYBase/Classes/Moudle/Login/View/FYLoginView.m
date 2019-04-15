//
//  FYLoginView.m
//  FYBase
//
//  Created by wang on 2019/4/11.
//  Copyright © 2019 wang. All rights reserved.
//

#import "FYLoginView.h"

@implementation FYLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
-(void)setupUI {
    UIImageView *loginImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 120, 100, 40)];
    loginImageView.backgroundColor = [UIColor colorWithHexString:@"#FDD000"];
    [self addSubview:loginImageView];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, loginImageView.fy_maxY + 10, kScreenw - 120, 30)];
    tipLabel.text = @"欢迎来到趣惠买商城";
    tipLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    tipLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:tipLabel];
    
    UITextField *accountTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(60, tipLabel.fy_maxY + 60 , kScreenw - 120, 44)];
    accountTextFiled.placeholder = @"请输入手机号";
    [self addSubview:accountTextFiled];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, accountTextFiled.fy_maxY, kScreenw - 30, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
    [self addSubview:lineView];
    
    UITextField *codeTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, lineView.fy_maxY + 40, kScreenw - 220  , 44)];
    codeTextField.placeholder = @"请输入验证码";
    
    UIButton *codeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [codeBtn setBackgroundColor:[UIColor colorWithHexString:@"#FDD000"]];
    codeBtn.frame = CGRectMake(codeTextField.fy_maxX, codeTextField.fy_y - 5, 120, 40);
    [codeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [codeBtn setCustomRectCorner:(UIRectCornerAllCorners) radius:20];
    [codeBtn addTarget:self action:@selector(openCountdown:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:codeBtn];
    
    [self addSubview:codeTextField];
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, codeTextField.fy_maxY, kScreenw - 30, 1)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#efefef"];
        [self addSubview:lineView];
    }
    
    UIButton *loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.loginBtn = loginBtn;
    [loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#FDD000"]];
    [loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    loginBtn.frame = CGRectMake(30, kScreenH - 60 - TabBarHeight - NavBarHight, kScreenw - 60, 60);
    [loginBtn setCustomRectCorner:(UIRectCornerAllCorners) radius:30];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:loginBtn];
}


// 开启倒计时效果
-(void)openCountdown:(UIButton *)sender{
    __block NSInteger time = 5; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮的样式
                [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置按钮显示读秒效果
                [sender setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

-(void)loginBtnClick:(UIButton *)sender {
    self.HUDView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenw, kScreenH)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.HUDView];
    self.HUDView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    
    //执行登录按钮转圈动画的view
    self.LoginAnimView = [[UIView alloc] initWithFrame:self.loginBtn.frame];
    self.LoginAnimView.layer.cornerRadius = 10;
    self.LoginAnimView.layer.masksToBounds = YES;
    self.LoginAnimView.frame = self.loginBtn.frame;
    self.LoginAnimView.backgroundColor = self.loginBtn.backgroundColor;
    [self addSubview:self.LoginAnimView];
    self.loginBtn.hidden = YES;
    
    CGPoint centerPoint = self.LoginAnimView.center;
    CGFloat radius = MIN(self.loginBtn.frame.size.width, self.loginBtn.frame.size.height);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.LoginAnimView.frame = CGRectMake(0, 0, radius, radius);
        self.LoginAnimView.center = centerPoint;
        self.LoginAnimView.layer.cornerRadius = radius/2;
        self.LoginAnimView.layer.masksToBounds = YES;
        
    }completion:^(BOOL finished) {
        
        //给圆加一条不封闭的白色曲线
        UIBezierPath* path = [[UIBezierPath alloc] init];
        [path addArcWithCenter:CGPointMake(radius/2, radius/2) radius:(radius/2 - 5) startAngle:0 endAngle:M_PI_2 * 2 clockwise:YES];
        self.shapeLayer = [[CAShapeLayer alloc] init];
        self.shapeLayer.lineWidth = 1.5;
        self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
        self.shapeLayer.fillColor = self.loginBtn.backgroundColor.CGColor;
        self.shapeLayer.frame = CGRectMake(0, 0, radius, radius);
        self.shapeLayer.path = path.CGPath;
        [self.LoginAnimView.layer addSublayer:self.shapeLayer];
        
        //让圆转圈，实现"加载中"的效果
        CABasicAnimation* baseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        baseAnimation.duration = 0.4;
        baseAnimation.fromValue = @(0);
        baseAnimation.toValue = @(2 * M_PI);
        baseAnimation.repeatCount = MAXFLOAT;
        [self.LoginAnimView.layer addAnimation:baseAnimation forKey:nil];
        
        //开始登录
        //        [self doLogin];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loginFail];
        });
    }];
    
}
/** 登录成功 */
- (void)loginSuccess {
    //移除蒙版
    [self.HUDView removeFromSuperview];
    //做响应的操作
    
}


/** 登录失败 */
- (void)loginFail {
    //把蒙版、动画view等隐藏，把真正的login按钮显示出来
    self.loginBtn.hidden = NO;
    [self.HUDView removeFromSuperview];
    [self.LoginAnimView removeFromSuperview];
    [self.LoginAnimView.layer removeAllAnimations];
    
    //给按钮添加左右摆动的效果(路径动画)
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGPoint point = self.LoginAnimView.layer.position;
    keyFrame.values = @[[NSValue valueWithCGPoint:CGPointMake(point.x, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x - 10, point.y)],
                        
                        [NSValue valueWithCGPoint:CGPointMake(point.x + 10, point.y)],
                        
                        [NSValue valueWithCGPoint:point]];
    keyFrame.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrame.duration = 0.5f;
    [self.loginBtn.layer addAnimation:keyFrame forKey:keyFrame.keyPath];
}

@end
