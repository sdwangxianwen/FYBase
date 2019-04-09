//
//  FYURL.h
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//填写各个网络请求的url地址

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/message.h>




NS_ASSUME_NONNULL_BEGIN

// Open iPhone X Style.（是否打开Phone X风格）
extern const Boolean kIsOpenIphoneXStyle;
// The default is 40， iPhone X Style Corner。（默认为40，iPhone X 圆角弧度）
extern const CGFloat kIphoneXStyleCorner;
// The default is 3， User guider image count。（默认为3，用户引导图总页数）
extern const NSInteger kUserGuiderImgCount;
// Screen system to return gesture.（是否屏蔽系统返回手势）
extern const Boolean kIsCanleSystemPan;
// The distance from the left can be automatically returned.(距离左边多少距离，可以自动返回)
extern const CGFloat kDistanceToLeft;
// BottomView Scaling.(底层缩放比例)
extern const CGFloat kWindowToScale;
// BottomView alpha.(底层透明度)
extern const CGFloat kMaskingAlpha;
// Automatic return speed.(自动返回速度)
extern const CGFloat kGestureSpeed;
// Range of drag and drop.(拖拽的范围,大于此值才有效果)
extern const CGFloat kDistanceToPan;
// The default is 0, 0 for full screen return, and also for distance.（默认为0，0为全屏返回，也可指定距离）
extern const CGFloat kDistanceToStart;


extern NSString *const HostAPI; //rootApi

//MARK: 首页

//MARK: 我的




@interface FYURL : NSObject

@end

NS_ASSUME_NONNULL_END
