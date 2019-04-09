//
//  FYNavgationController.m
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#import "FYNavgationController.h"
#import "FYGestureBaseController.h"
#import "AppDelegate.h"

@interface FYNavgationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation FYNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayScreenshot = [NSMutableArray array];
    
    //屏蔽系统的手势
    self.interactivePopGestureRecognizer.enabled = !kIsCanleSystemPan;
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    _panGesture.delegate = self;
    [self.view addGestureRecognizer:_panGesture];
    
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.view == self.view && [gestureRecognizer locationInView:self.view].x < (kDistanceToStart == 0 ? UIScreen.mainScreen.bounds.size.width : kDistanceToStart)) {
        FYGestureBaseController *topView = (FYGestureBaseController *)self.topViewController;
        if (!topView.isEnablePanGesture)
            return NO;
        else {
            CGPoint translate = [gestureRecognizer translationInView:self.view];
            BOOL possible = translate.x != 0 && fabs(translate.y) == 0;
            if (possible)
                return YES;
            else
                return NO;
            return YES;
        }
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPanGestureRecognizer")] || [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIPanGestureRecognizer")]|| [otherGestureRecognizer isKindOfClass:NSClassFromString(@"UIScrollViewPagingSwipeGestureRecognizer")]) {
        UIView *aView = otherGestureRecognizer.view;
        if ([aView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *sv = (UIScrollView *)aView;
            if (sv.contentOffset.x==0) {
                return YES;
            }
        }
        return NO;
    }
    return YES;
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *rootVC = appDelegate.window.rootViewController;
    UIViewController *presentedVC = rootVC.presentedViewController;
    if (self.viewControllers.count == 1) {
        return;
    }
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        if (IPHONE_X && kIsOpenIphoneXStyle) {
            rootVC.view.layer.masksToBounds = YES;
            rootVC.view.layer.cornerRadius = kIphoneXStyleCorner;
            presentedVC.view.layer.masksToBounds = YES;
            presentedVC.view.layer.cornerRadius = kIphoneXStyleCorner;
        }
        appDelegate.gestureBaseView.hidden = NO;
    }
    else if (panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point_inView = [panGesture translationInView:self.view];
        if (point_inView.x >= kDistanceToPan) {
            rootVC.view.transform = CGAffineTransformMakeTranslation(point_inView.x - kDistanceToPan, 0);
            presentedVC.view.transform = CGAffineTransformMakeTranslation(point_inView.x - kDistanceToPan, 0);
        }
    }
    else if (panGesture.state == UIGestureRecognizerStateEnded) {
        CGPoint point_inView = [panGesture translationInView:self.view];
        if (point_inView.x >= kDistanceToLeft) {
            [UIView animateWithDuration:kGestureSpeed animations:^{
                rootVC.view.transform = CGAffineTransformMakeTranslation(([UIScreen mainScreen].bounds.size.width), 0);
                presentedVC.view.transform = CGAffineTransformMakeTranslation(([UIScreen mainScreen].bounds.size.width), 0);
            } completion:^(BOOL finished) {
                [self popViewControllerAnimated:NO];
                rootVC.view.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
                appDelegate.gestureBaseView.hidden = YES;
            }];
        }
        else {
            [UIView animateWithDuration:kGestureSpeed animations:^{
                rootVC.view.transform = CGAffineTransformIdentity;
                presentedVC.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (IPHONE_X && kIsOpenIphoneXStyle) {
                    rootVC.view.layer.masksToBounds = NO;
                    rootVC.view.layer.cornerRadius = 0;
                    presentedVC.view.layer.masksToBounds = NO;
                    presentedVC.view.layer.cornerRadius = 0;
                }
                appDelegate.gestureBaseView.hidden = YES;
            }];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    FYGestureBaseController *topView = (FYGestureBaseController *)self.topViewController;
    if (topView.isEnablePanGesture == NO)     return NO;
    if (self.viewControllers.count <= 1)    return NO;
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint point = [touch locationInView:gestureRecognizer.view];
        if (point.x < [UIScreen mainScreen].bounds.size.width) {
            return YES;
        }
    }
    return NO;
}
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *arr = [super popToViewController:viewController animated:animated];
    if (self.arrayScreenshot.count > arr.count){
        for (int i = 0; i < arr.count; i++) {
            [self.arrayScreenshot removeLastObject];
        }
    }
    return arr;
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count == 0) {
        return [super pushViewController:viewController animated:animated];
    }else if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(appdelegate.window.frame.size.width, appdelegate.window.frame.size.height), YES, 0);
    [appdelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.arrayScreenshot addObject:viewImage];
    appdelegate.gestureBaseView.imgView.image = viewImage;
    [super pushViewController:viewController animated:animated];
}
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.arrayScreenshot removeLastObject];
    UIImage *image = [self.arrayScreenshot lastObject];
    if (image)
        appdelegate.gestureBaseView.imgView.image = image;
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    
    return viewController;
}
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (self.arrayScreenshot.count > 2) {
        [self.arrayScreenshot removeObjectsInRange:NSMakeRange(1, self.arrayScreenshot.count - 1)];
    }
    UIImage *image = [self.arrayScreenshot lastObject];
    if (image)
        appdelegate.gestureBaseView.imgView.image = image;
    return [super popToRootViewControllerAnimated:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
