//
//  UIImage+FYColor.m
//  FYBase
//
//  Created by wang on 2019/4/10.
//  Copyright © 2019 wang. All rights reserved.
//

#import "UIImage+FYColor.h"

@implementation UIImage (FYColor)
+ (UIImage *)imageWithColor:(UIColor *)color {
    if (color == nil) {
        return nil;
    }
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
