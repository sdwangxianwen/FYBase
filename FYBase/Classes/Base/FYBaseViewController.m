//
//  FYBaseViewController.m
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#import "FYBaseViewController.h"

@interface FYBaseViewController ()

@end

@implementation FYBaseViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self] > 0) {
        [self initLeftBtn];
    } else {
        [self.navigationController setNavigationBarHidden:YES];
    }
    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//MARK:创建左边按钮
-(void)initLeftBtn {
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [_leftBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    [_leftBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    _leftBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_leftBtn setImage:[UIImage imageNamed:@"customBack"] forState:UIControlStateNormal];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    self.navigationItem.leftBarButtonItem = barItem;
}
-(void)leftBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 展示空页面
 */
-(void)showEmptyView {
    self.mainTableView.showEmptyView = YES;
}

//MARK:创建右边按钮
-(void)initRightBtn {
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_rightBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn setImage:[UIImage imageNamed:@"customBack"] forState:UIControlStateNormal];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:_leftBtn];
    self.navigationItem.rightBarButtonItem = barItem;
}
-(void)rightBtnClick {
    
}


/**
 MARK:下拉刷新
 */
-(void)dropdownRefresh {
//    [self.mainTableView.mj_header endRefreshing];
}

/**
 MARK: 上拉加载
 */
-(void)pullLoading {
//    [self.mainTableView.mj_footer endRefreshing];
}

-(UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        if ([self.navigationController.viewControllers indexOfObject:self] > 0) {
            _mainTableView.frame = CGRectMake(0, NavBarHight, kScreenw, kScreenH - NavBarHight);
        } else {
            _mainTableView.frame = CGRectMake(0, 0, kScreenw, kScreenH - TabBarHeight);
        }
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        self.mainTableView.estimatedRowHeight = 100;
        self.mainTableView.rowHeight = UITableViewAutomaticDimension;
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        if (self.needDropRefresh) {
//            _mainTableView.mj_header = [QHMFreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(dropdownRefresh)];
        }
        if (self.needUpLoad) {
//            _mainTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullLoading)];
        }
        //        _mainTableView.hidden = self.noNetView;
    }
    return _mainTableView;
}

@end
