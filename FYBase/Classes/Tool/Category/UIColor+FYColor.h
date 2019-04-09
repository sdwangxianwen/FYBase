//
//  UIColor+FYColor.h
//  quhuimai
//
//  Created by wang on 2019/4/1.
//  Copyright © 2019 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FYColor)
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (instancetype)colorRandom;
@end

NS_ASSUME_NONNULL_END
