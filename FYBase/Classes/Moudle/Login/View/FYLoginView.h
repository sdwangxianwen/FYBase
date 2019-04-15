//
//  FYLoginView.h
//  FYBase
//
//  Created by wang on 2019/4/11.
//  Copyright © 2019 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FYLoginView : UIView
@property (nonatomic, strong)UIButton *loginBtn;
//登录时加一个看不见的蒙版，让控件不能再被点击
@property (nonatomic,strong) UIView *HUDView;
//执行登录按钮动画的view (动画效果不是按钮本身，而是这个view)
@property (nonatomic,strong) UIView *LoginAnimView;
//登录转圈的那条白线所在的layer
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@end

NS_ASSUME_NONNULL_END
