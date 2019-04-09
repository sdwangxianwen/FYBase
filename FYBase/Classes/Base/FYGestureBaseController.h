//
//  FYGestureBaseController.h
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,popType) {
    popTypeViewController,
    popTypeToViewController,
    popTypeToRootViewController
};

NS_ASSUME_NONNULL_BEGIN

@interface FYGestureBaseController : UIViewController
@property (nonatomic) popType blankType;// default is popTypeViewController.
@property (nonatomic) Boolean isEnablePanGesture;// default is YES.

- (void)popViewController;
- (void)popToViewController:(UIViewController *)viewController;
- (void)popToRootViewController;
@end

NS_ASSUME_NONNULL_END

@interface gestureBaseView : UIView
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) NSMutableArray *arrayImage;

- (void)showEffectChange:(CGPoint)pt;
- (void)restore;
- (void)screenShot;
- (void)removeObserver;
- (void)addObserver;
@end
