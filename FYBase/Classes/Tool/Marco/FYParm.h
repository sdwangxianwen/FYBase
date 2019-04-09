//
//  FYParm.h
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#ifndef FYParm_h
#define FYParm_h
#define FYLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])

#define kScreenw [UIScreen mainScreen].bounds.size.width //屏幕宽度
#define kScreenH [UIScreen mainScreen].bounds.size.height //屏幕高度
#define kWidth  kScreenw/375.0 //宽度比例
#define kHeight kScreenH/667.0 //高度比例
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object; //弱
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object; //强
//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
// 是否是iPhoneX
// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define IPHONE_X \
({BOOL IPHONE_X = NO;\
if (@available(iOS 11.0, *)) {\
IPHONE_X = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(IPHONE_X);})

// 顶部区域
#define NavBarHight (IPHONE_X ? 88 : 64)
// 状态栏高度
#define StatusBarHeight (IPHONE_X ? 44.f : 20.f)
// tabBar高度
#define TabBarHeight (IPHONE_X ? 83 : 49.f)
//全面屏底部的手势高度
#define BottomLineHeight (IPHONE_X ? 34.f: 0.f)
#endif /* FYParm_h */
