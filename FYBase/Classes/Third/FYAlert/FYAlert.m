//
//  FYAlert.m
//  FYAlertView
//
//  Created by wang on 2019/4/8.
//  Copyright © 2019 wang. All rights reserved.
//

#import "FYAlert.h"


static inline CGSize
labelSizeWithTextAndWidthAndFont(NSString *text, CGFloat width, UIFont *font){
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect frame = [text boundingRectWithSize:size
                                      options:
                    NSStringDrawingTruncatesLastVisibleLine |
                    NSStringDrawingUsesLineFragmentOrigin |
                    NSStringDrawingUsesFontLeading
                                   attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : style} context:nil];
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
    return newFrame.size;
}


@interface FYAlert ()
/**
标题,可为nil
 */
@property (nonatomic, strong)UILabel *titleLabel;
/**
 提示内容
 */
@property (nonatomic, strong)UILabel *messageLabel;
/**
 按钮数组
 */
@property (nonatomic, strong)NSMutableArray *buttonArrM;
/**
 按钮标题数组
 */
@property (nonatomic, strong)NSArray *buttonTitleArr;
/**
 按钮颜色数组
 */
@property (nonatomic, strong)NSArray *buttonColorArr;
/**
 标题
 */
@property (nonatomic, strong) NSString *title;
/**
 提示信息
 */
@property (nonatomic, strong) NSString  *message;
/**
 背景图片
 */
@property (nonatomic, strong) UIImage  *image;
/**
 背景视图
 */
@property (nonatomic, strong)UIView *bgView;
/**
 蒙版
 */
@property (nonatomic, strong)UIView *coverView;
@end

@implementation FYAlert

+ (void)showWithTitle:(NSString *)title
              message:(NSString *)message
     buttonTitleArray:(NSArray <NSString *>*)buttonTitleArray
buttonTitleColorArray:(NSArray <UIColor *>*)buttonTitleColorArray
          actionBlock:(buttonActionBlock)actionBlock {
    FYAlert *alertView = [[FYAlert alloc] showTitle:title message:message buttonTitles:buttonTitleArray buttonTitlesColor:buttonTitleColorArray];
    alertView.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:alertView];
    alertView.actionBlock = actionBlock;
}

- (instancetype)showTitle:(NSString *)title
                     message:(NSString *)message
                buttonTitles:(NSArray *)buttonTitles
           buttonTitlesColor:(NSArray <UIColor *>*)buttonTitlesColor {
    if (self == [super initWithFrame:CGRectZero]) {
        if ([title isEqualToString:@""]) {
            title = nil;
        }
        [self coverView];
        _title = [title copy];
        _message  = [message copy];
        self.buttonTitleArr = [NSArray arrayWithArray:buttonTitles];
        self.buttonColorArr = [NSArray arrayWithArray:buttonTitlesColor];
        [self setupUI];
        [self showAnimationWithView:self.bgView];
    }
    return self;
}
- (void)showAnimationWithView:(UIView *)animationView {
    [animationView animation_scaleShowWithDuration:0.3 ratio:1.0 finishBlock:^{

    }];
}
-(void)dismiss {
    [self.bgView animation_scaleDismissWithDuration:0.3 ratio:1.0 finishBlock:^{
        [self removeFromSuperview];
    }];
}

-(void)setupUI {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 120;
    CGSize titleLabelSize = labelSizeWithTextAndWidthAndFont(self.title, width, self.titleLabel.font);
     CGSize messageLabelSize = labelSizeWithTextAndWidthAndFont(self.message, width, self.messageLabel.font);
    self.titleLabel.frame = CGRectMake(0, 5, titleLabelSize.width, titleLabelSize.height);
    self.messageLabel.frame = CGRectMake(0, self.titleLabel.fy_maxY, messageLabelSize.width, MAX(60, messageLabelSize.height));
    CGFloat height = self.messageLabel.fy_maxY + ( self.buttonTitleArr.count > 2 ? (44 * self.buttonTitleArr.count) : 44);
    self.bgView.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - width)/2, ([UIScreen mainScreen].bounds.size.height - height)/2, width, height);
    if (self.buttonColorArr.count < self.buttonTitleArr.count) {
        NSMutableArray *mutArr = [NSMutableArray array];
        for (NSInteger i = 0; i < self.buttonTitleArr.count; i ++) {
            [mutArr addObject:[UIColor blueColor]];
        }
        self.buttonColorArr = [mutArr mutableCopy];
    }
    //按钮
    if (self.buttonTitleArr.count == 1) {
        //只有一个按钮
        [self addButton:CGRectMake(0, self.bgView.fy_height - 44, width, 44) title:self.buttonTitleArr[0] tag:0 titleColor:self.buttonColorArr[0]];
    } else if (self.buttonTitleArr.count == 2) {
        //两个按钮
        for (NSInteger i = 0; i < self.buttonTitleArr.count; i ++) {
            CGRect button_frame = CGRectMake(self.bgView.fy_width/2 * i, self.messageLabel.fy_maxY, (self.bgView.fy_width)/2, 44);
            [self addButton:button_frame title:self.buttonTitleArr[i] tag:i titleColor:self.buttonColorArr[i]];
        }
    } else if (self.buttonTitleArr.count > 2) {
        //三个以上按钮
        for (NSInteger i = 0; i < self.buttonTitleArr.count; i ++) {
            CGRect button_frame = CGRectMake(0, self.messageLabel.fy_maxY + 44 * i, width, 44);
            [self addButton:button_frame title:self.buttonTitleArr[i] tag:i titleColor:self.buttonColorArr[i]];
        }
    }
}
-(void)addButton:(CGRect)frame
           title:(NSString *)title
             tag:(NSInteger)tag
      titleColor:(UIColor *)titleColor {
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    if (tag == 0) {
        [button addBorder:(borderDirectionTypeTop) color:[UIColor grayColor] width:0.5];
        [button addBorder:(borderDirectionTypeRight) color:[UIColor grayColor] width:0.5];
    } else {
        [button addBorder:(borderDirectionTypeTop) color:[UIColor grayColor] width:0.5];
    }
    
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.tag = tag;
    [button setTitle:title forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [button setTitleColor:titleColor forState:(UIControlStateNormal)];
    [self.bgView addSubview:button];
    [self.buttonArrM addObject:button];
    
}

-(void)buttonClick:(UIButton *)sender {
    [self dismiss];
    if (self.actionBlock) {
        self.actionBlock(self, sender.tag);
    }
}

-(NSMutableArray *)buttonArrM {
    if (!_buttonArrM) {
        _buttonArrM = [NSMutableArray array];
    }
    return _buttonArrM;
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        [self addSubview:_bgView];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 4;
        _bgView.clipsToBounds = YES;
       
    }
    return _bgView;
}
-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.bgView addSubview:_titleLabel];
        _titleLabel.text = self.title;
    }
    return _titleLabel;
}
-(UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        [self.bgView addSubview:_messageLabel];
        _messageLabel.font = [UIFont systemFontOfSize:18];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
       _messageLabel.text = self.message;
    }
    return _messageLabel;
}
-(UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        [self addSubview:_coverView];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.3;
    }
    return _coverView;
}


@end
