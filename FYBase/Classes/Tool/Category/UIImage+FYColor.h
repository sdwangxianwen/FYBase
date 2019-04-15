//
//  UIImage+FYColor.h
//  FYBase
//
//  Created by wang on 2019/4/10.
//  Copyright © 2019 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (FYColor)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(NSString *)color alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
