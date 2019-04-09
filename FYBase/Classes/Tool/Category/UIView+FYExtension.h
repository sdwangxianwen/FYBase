//
//  UIView+FYExtension.h
//  FYAlertView
//
//  Created by wang on 2018/8/2.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FYBaseViewController;
typedef NS_ENUM(NSInteger,borderDirectionType) {
    borderDirectionTypeTop,
    borderDirectionTypeLeft,
    borderDirectionTypeBottom,
    borderDirectionTypeRight
};

@interface UIView (FYExtension)
@property (nonatomic, assign) CGFloat fy_x;
@property (nonatomic, assign) CGFloat fy_y;
@property (nonatomic, assign) CGFloat fy_width;
@property (nonatomic, assign) CGFloat fy_height;
@property (nonatomic, assign) CGFloat fy_centerX;
@property (nonatomic, assign) CGFloat fy_centerY;
@property (nonatomic, assign) CGSize  fy_size;
@property (nonatomic, assign) CGPoint fy_origin;
@property (nonatomic, assign, readonly) CGFloat fy_maxX;
@property (nonatomic, assign, readonly) CGFloat fy_minX;
@property (nonatomic, assign, readonly) CGFloat fy_maxY;
@property (nonatomic, assign, readonly) CGFloat fy_minY;

/**
 获取当前的控制器
 */
- (FYBaseViewController *)getCurrentViewController;

- (void)addBorder:(borderDirectionType)direction color:(UIColor*)color width:(CGFloat)width;
/**
 设置一个view的radius
 @param corners corner
 @param radius 角度
 */
- (void)setCustomRectCorner:(UIRectCorner)corners radius:(CGFloat)radius;

/*
 * 将会把一个view变成圆形，并将它描边, 因为没有使用view 的layer
 * 不要设置该view的layer 属性。
 */
- (void)sn_ClipToCircle:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width;

@end
