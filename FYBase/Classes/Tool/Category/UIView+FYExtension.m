//
//  UIView+FYExtension.m
//  FYAlertView
//
//  Created by wang on 2018/8/2.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "UIView+FYExtension.h"
#import <objc/runtime.h>


static const void *kborderLayerKey = &kborderLayerKey;

@implementation UIView (FYExtension)
- (void)setFy_x:(CGFloat)fy_x{
    
    CGRect frame = self.frame;
    frame.origin.x = fy_x;
    self.frame = frame;
}
- (CGFloat)fy_x
{
    return self.frame.origin.x;
}

- (void)setFy_y:(CGFloat)fy_y{
    
    CGRect frame = self.frame;
    frame.origin.y = fy_y;
    self.frame = frame;
}
- (CGFloat)fy_y
{
    return self.frame.origin.y;
}

- (void)setFy_centerX:(CGFloat)fy_centerX{
    CGPoint center = self.center;
    center.x = fy_centerX;
    self.center = center;
}
- (CGFloat)fy_centerX
{
    return self.center.x;
}

- (void)setFy_centerY:(CGFloat)fy_centerY
{
    CGPoint center = self.center;
    center.y = fy_centerY;
    self.center = center;
}
- (CGFloat)fy_centerY
{
    return self.center.y;
}

- (void)setFy_width:(CGFloat)fy_width
{
    CGRect frame = self.frame;
    frame.size.width = fy_width;
    self.frame = frame;
}
- (CGFloat)fy_width
{
    return self.frame.size.width;
}

- (void)setFy_height:(CGFloat)fy_height
{
    CGRect frame = self.frame;
    frame.size.height = fy_height;
    self.frame = frame;
}
- (CGFloat)fy_height
{
    return self.frame.size.height;
}

- (void)setFy_size:(CGSize)fy_size
{
    CGRect frame = self.frame;
    frame.size = fy_size;
    self.frame = frame;
}
- (CGSize)fy_size
{
    return self.frame.size;
}

- (void)setFy_origin:(CGPoint)fy_origin
{
    CGRect frame = self.frame;
    frame.origin = fy_origin;
    self.frame = frame;
}

- (CGPoint)fy_origin
{
    return self.frame.origin;
}
- (CGFloat)fy_maxX{
    return self.frame.origin.x + self.frame.size.width;
}
- (CGFloat)fy_maxY{
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)fy_minX {
    return CGRectGetMinX(self.frame);
}
-(CGFloat)fy_minY {
    return CGRectGetMinY(self.frame);
}
- (FYBaseViewController *)getCurrentViewController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (FYBaseViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

- (void)setCustomRectCorner:(UIRectCorner)corners radius:(CGFloat)radius{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: self.bounds
                                                   byRoundingCorners: corners
                                                         cornerRadii: CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}



- (void)sn_ClipToCircle:(CGRect)frame borderColor:(UIColor *)borderColor borderWidth:(CGFloat)width{
    // 加入环形mask
    CGPathRef path = CGPathCreateWithEllipseInRect(frame, NULL);
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = frame;
    maskLayer.path = path;
    self.layer.mask = maskLayer;
    CAShapeLayer *borderLayer = [[CAShapeLayer alloc] init];
    borderLayer.path = path;
    CGPathRelease(path);
    
    borderLayer.strokeColor = borderColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.frame = frame;
    borderLayer.lineWidth = width*2;
    
    if (!!self.borderLayer) {
        [self.borderLayer removeFromSuperlayer];
    }
    
    [self.layer addSublayer:borderLayer];
    self.borderLayer = borderLayer;
}

- (void)setBorderLayer:(CALayer *)borderLayer{
    objc_setAssociatedObject(self, kborderLayerKey, borderLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAShapeLayer *)borderLayer{
    return objc_getAssociatedObject(self, kborderLayerKey);
}

- (void)addBorder:(borderDirectionType)direction color:(UIColor*)color width:(CGFloat)width {
    CALayer*border = [CALayer layer];
    border.backgroundColor= color.CGColor;
    switch (direction) {
        case borderDirectionTypeTop:
            border.frame=CGRectMake(0.0f,0.0f,self.bounds.size.width, width);
            break;
        case borderDirectionTypeLeft:
            border.frame=CGRectMake(0.0f,0.0f,width, self.bounds.size.height);
            break;
        case borderDirectionTypeBottom:
            border.frame=CGRectMake(0.0f,self.bounds.size.height- width,self.bounds.size.width, width);
            break;
        case borderDirectionTypeRight:
            border.frame=CGRectMake(self.bounds.size.width- width,0, width,self.bounds.size.height);
            break;
            
        default:
            break;
    }
    [self.layer addSublayer:border];
}


@end
