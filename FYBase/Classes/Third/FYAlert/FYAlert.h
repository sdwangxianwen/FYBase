//
//  FYAlert.h
//  FYAlertView
//
//  Created by wang on 2019/4/8.
//  Copyright © 2019 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FYAlert;
typedef void(^buttonActionBlock)(FYAlert *alertView, NSInteger index);

@interface FYAlert : UIView

/**
 背景颜色 默认：半透明
 */
@property (nonatomic, strong) UIColor *bgColor;
/**
 背景图片名字,默认没有图片
 */
@property (nonatomic, strong) NSString *bgImageName;
/**
 按钮的点击事件
 */
@property (nonatomic, copy) buttonActionBlock actionBlock;
/*!
 *  创建一个类似于系统的alert
 *
 *  @param title         标题：可空
 *  @param message       消息内容：可空
 *  @param buttonTitleArray  按钮标题：不可空
 *  @param buttonTitleColorArray  按钮标题颜色：可空，默认蓝色
 *  @param actionBlock        按钮的点击事件处理
 */
+ (void)showWithTitle:(NSString *)title
                      message:(NSString *)message
             buttonTitleArray:(NSArray <NSString *>*)buttonTitleArray
        buttonTitleColorArray:(NSArray <UIColor *>*)buttonTitleColorArray
                  actionBlock:(buttonActionBlock)actionBlock;
@end

NS_ASSUME_NONNULL_END
