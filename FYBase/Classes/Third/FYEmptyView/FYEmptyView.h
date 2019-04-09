//
//  FYEmptyView.h
//  emptyView
//
//  Created by wang on 2018/7/31.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,FYEmptyViewStatus) {
    FYEmptyViewStatusAddress, //空地址
    FYEmptyViewStatusOrder  //空订单
};
typedef void(^emptyClickBlock)(void);
@interface FYEmptyView : UIView
@property(nonatomic,strong)  UIImageView *imageView;
@property(nonatomic,strong) UILabel* titleLabel;
@property (nonatomic, strong)UIButton *emptyBtn;
@property(nonatomic,copy) emptyClickBlock emptyClickBlock;
@property(nonatomic,assign)FYEmptyViewStatus status;


+(FYEmptyView *)initEmptyViewWithTitle:(NSString *)title imageName:(NSString *)imageName bounds:(CGRect)bounds backgroundColor:(UIColor *)backgroundColor;

+(FYEmptyView *)initEmptyViewWithTitle:(NSString *)title imageName:(NSString *)imageName bounds:(CGRect)bounds status:(FYEmptyViewStatus)status;

@end
