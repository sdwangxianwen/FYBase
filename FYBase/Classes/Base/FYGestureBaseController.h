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
/**
 是否需要添加返回手势,默认是
 */
@property (nonatomic) Boolean isEnablePanGesture;

- (void)popViewController;
- (void)popToViewController:(UIViewController *)viewController;
- (void)popToRootViewController;
@end

NS_ASSUME_NONNULL_END

NS_ASSUME_NONNULL_BEGIN
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
NS_ASSUME_NONNULL_END
