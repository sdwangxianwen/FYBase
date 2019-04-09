//
//  FYGestureBaseController.m
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#import "FYGestureBaseController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

static char ListenTaarViewMove[] = "ListenTaarViewMove";
@interface FYGestureBaseController ()

@end

@implementation FYGestureBaseController

- (id)init{
    self = [super init];
    if (self) {
        self.isEnablePanGesture = YES;
        self.blankType = popTypeViewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

    
-(void)basePopViewController:(UIViewController *)viewController PopType:(popType)popType{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootVC = appDelegate.window.rootViewController;
    UIViewController *presentedVC = rootVC.presentedViewController;
    appDelegate.gestureBaseView.hidden = NO;
    
    appDelegate.gestureBaseView.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:kMaskingAlpha];
    appDelegate.gestureBaseView.imgView.transform = CGAffineTransformMakeScale(kWindowToScale, kWindowToScale);
    
    [UIView animateWithDuration:kGestureSpeed animations:^{
        rootVC.view.transform = CGAffineTransformMakeTranslation(([UIScreen mainScreen].bounds.size.width), 0);
        presentedVC.view.transform = CGAffineTransformMakeTranslation(([UIScreen mainScreen].bounds.size.width), 0);
        if (IPHONE_X && kIsOpenIphoneXStyle) {
            rootVC.view.layer.masksToBounds = YES;
            rootVC.view.layer.cornerRadius = kIphoneXStyleCorner;
            presentedVC.view.layer.masksToBounds = YES;
            presentedVC.view.layer.cornerRadius = kIphoneXStyleCorner;
        }
    } completion:^(BOOL finished) {
        switch (popType) {
            case popTypeViewController:
                [self.navigationController popViewControllerAnimated:NO];
                break;
            case popTypeToViewController:
                [self.navigationController popToViewController:viewController animated:NO];
                break;
            case popTypeToRootViewController:
                [self.navigationController popToRootViewControllerAnimated:NO];
                break;
            default:
                break;
        }
        rootVC.view.transform = CGAffineTransformIdentity;
        presentedVC.view.transform = CGAffineTransformIdentity;
        if (IPHONE_X && kIsOpenIphoneXStyle) {
            rootVC.view.layer.masksToBounds = NO;
            rootVC.view.layer.cornerRadius = 0;
            presentedVC.view.layer.masksToBounds = NO;
            presentedVC.view.layer.cornerRadius = 0;
        }
        appDelegate.gestureBaseView.hidden = YES;
        
    }];
}

- (void)popViewController{
    [self basePopViewController:nil PopType:popTypeViewController];
}

-(void)popToRootViewController{
    [self basePopViewController:nil PopType:popTypeToRootViewController];
}

-(void)popToViewController:(UIViewController *)viewController{
    [self basePopViewController:viewController PopType:popTypeToViewController];
}
@end


@interface gestureBaseView()
@property(nonatomic,weak)UIView *rootControllerView;
@end

@implementation gestureBaseView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.arrayImage = [NSMutableArray array];
        self.backgroundColor = [UIColor blackColor];
        self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
        if (IPHONE_X && kIsOpenIphoneXStyle) {
            self.imgView.layer.masksToBounds = YES;
            self.imgView.layer.cornerRadius = kIphoneXStyleCorner;
        }
        self.maskView = [[UIView alloc] initWithFrame:self.bounds];
        self.maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:kMaskingAlpha];
        [self addSubview: self.imgView];
        [self addSubview: self.maskView];
        [self addObserver];
    }
    return self;
}

- (void)removeObserver {
    [self.rootControllerView removeObserver:self forKeyPath:@"transform" context:ListenTaarViewMove];
}

- (void)addObserver {
    self.rootControllerView = [AppDelegate shareAppDelegate].window.rootViewController.view;
    [self.rootControllerView addObserver:self forKeyPath:@"transform" options:NSKeyValueObservingOptionNew context:ListenTaarViewMove];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (context == ListenTaarViewMove){
        NSValue *value  = [change objectForKey:NSKeyValueChangeNewKey];
        CGAffineTransform newTransform = [value CGAffineTransformValue];
        [self showEffectChange:CGPointMake(newTransform.tx, 0) ];
    }
}

- (void)showEffectChange:(CGPoint)pt{
    
    if (pt.x > 0){
        _maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:-pt.x / ([UIScreen mainScreen].bounds.size.width) * kMaskingAlpha + kMaskingAlpha];
        _imgView.transform = CGAffineTransformMakeScale(kWindowToScale + (pt.x / ([UIScreen mainScreen].bounds.size.width) * (1 - kWindowToScale)), kWindowToScale + (pt.x / ([UIScreen mainScreen].bounds.size.width) * (1 - kWindowToScale)));
    }
    if (pt.x < 0){
        _maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.5];
        _imgView.transform = CGAffineTransformIdentity;
    }
}

- (void)restore {
    if (_maskView && _imgView){
        _maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:kMaskingAlpha];
        _imgView.transform = CGAffineTransformMakeScale(kWindowToScale, kWindowToScale);
    }
}

- (void)screenShot{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height), YES, 0);
    [appDelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRef];
    self.imgView.image = sendImage;
    self.imgView.transform = CGAffineTransformMakeScale(kWindowToScale, kWindowToScale);
}

- (void)dealloc{
    [self removeObserver];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}
@end
