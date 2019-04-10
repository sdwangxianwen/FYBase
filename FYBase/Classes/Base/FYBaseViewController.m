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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self.navigationController.viewControllers indexOfObject:self] > 0) {
        [self initLeftBtn];
    } else {
        self.fd_prefersNavigationBarHidden = YES;
    }
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
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
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

-(NSMutableArray *)listArrM {
    if (!_listArrM) {
        _listArrM = [NSMutableArray array];
    }
    return _listArrM;
}

#pragma mark:tableviewsource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isGroup) {
        return self.listArrM.count;
    } else {
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isGroup) {
        if ([self.listArrM[section] isKindOfClass:[NSArray class]]) {
            NSArray *arr = self.listArrM[section];
            return arr.count;
        }
        return 1;
    }
    return self.listArrM.count;
}

#pragma mark:tableviewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   UITableViewCell *cell = [[NSClassFromString(self.cellID) alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:self.cellID];
    if (!cell) {
        cell = [tableView dequeueReusableCellWithIdentifier:self.cellID forIndexPath:indexPath];
    }
    [self configCell:cell indexPath:indexPath];
    return cell;
}

- (void)configureCell:(id)cell item:(id)item {
    
}

-(void)configCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    if (self.isGroup) {
        if ([self.listArrM[indexPath.section] isKindOfClass:[NSArray class]]) {
            NSArray *arr = self.listArrM[indexPath.section];
            [self configureCell:cell item:arr[indexPath.row]];
        } else {
            [self configureCell:cell item:self.listArrM[indexPath.section]];
        }
        
    } else {
        [self configureCell:cell item:self.listArrM[indexPath.row]];
    }
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetY = scrollView.contentOffset.y;
//    if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
//        if (offsetY > StatusBarHeight) {
//            self.fd_prefersNavigationBarHidden = NO;
////            self.customNav.alpha = MIN(1,1 - (( NavBarHight + STATUS_BAR_HEIGHT - offsetY) / NavBarHight));
//        }else {
//            self.fd_prefersNavigationBarHidden = YES;
////            self.customNav.alpha = 0;
//        }
//    } else {
//        if (offsetY > StatusBarHeight) {
////            self.navigationItem.title = self.titleLabel.text;
//        } else {
//            self.navigationItem.title = @"";
//        }
//    }
//}

@end
