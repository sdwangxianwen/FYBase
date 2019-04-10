//
//  FYBaseViewController.h
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+FDFullscreenPopGesture.h"


NS_ASSUME_NONNULL_BEGIN

@interface FYBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
/**
 主视图,懒加载,需要的时候调用即可
 */
@property (nonatomic, strong)UITableView *mainTableView;
/**
 左边按钮
 */
@property (nonatomic, strong)UIButton *leftBtn;
/**
 右边按钮
 */
@property (nonatomic, strong)UIButton *rightBtn; //
/**
 是否需要下拉刷新,要写在加载当前tableview之前
 */
@property (nonatomic,assign)BOOL needDropRefresh; //
/**
 是否需要上拉加载
 */
@property (nonatomic,assign)BOOL needUpLoad;
@property (nonatomic, strong)NSMutableArray *listArrM; //数据的数组
@property (nonatomic, strong)NSString *cellID;
/**
 //创建多个不同的cell的数组,以字典形式列出,key值代表对应的第几行或是第几组
 */
//@property (nonatomic, strong)NSArray<NSDictionary *> *cellArr;
/**
 //是否分组
 */
@property(nonatomic,assign)BOOL isGroup;
/**
 绑定cell的数据,只是用简单的cell布局,复杂的还是用常规代理方法实现
 @param cell 自定义cell
 */
- (void)configureCell:(id)cell item:(id)item;
/**
 创建nav的右边按钮
 */
-(void)initRightBtn;
/**
 下拉刷新
 */
-(void)dropdownRefresh;
/**
 上拉加载
 */
-(void)pullLoading;
/**
 展示空数据,到当前的tableview上面
 */
-(void)showEmptyView;
@end

NS_ASSUME_NONNULL_END
