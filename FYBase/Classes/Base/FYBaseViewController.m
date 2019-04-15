//
//  FYBaseViewController.m
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#import "FYBaseViewController.h"


@interface FYBaseViewController ()<UIGestureRecognizerDelegate>


@end

@implementation FYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self createBgview];
    [self initNavBar];
    [self setupNavLayout];
    
}
-(void)initMainTableView {
//    [self.view insertSubview:self.mainTableView belowSubview:self.navView];
    [self.view addSubview:self.mainTableView];
}
//MARK:自定义navBar
-(void)initNavBar {
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    FYCustomNavView *navView = [[FYCustomNavView alloc] initWithFrame:CGRectMake(0, 0, kScreenw, NavBarHight)];
    self.navView = navView;
    [self.view addSubview:navView];
    
    [self.navView addSubview:self.leftBtn];
    [self.navView addSubview:self.rightBtn];
    [self.navView addSubview:self.righOthertBtn];
    self.leftBtn.hidden = [self.navigationController.viewControllers indexOfObject:self] <= 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view bringSubviewToFront:self.navView];
    });
    
}
//设置约束
-(void)setupNavLayout {
    self.leftBtn.frame = CGRectMake(0, StatusBarHeight, 60*kWidth, 44);
    self.rightBtn.frame = CGRectMake(kScreenw - 44*kWidth, StatusBarHeight, 44*kWidth, 44);
    self.righOthertBtn.frame  =CGRectMake(kScreenw - 88*kWidth, StatusBarHeight, 44*kWidth, 44);
}
-(void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    _navView.titleLabel.text = navTitle;
}
-(void)setNavColor:(NSString *)navColor {
    _navColor = navColor;
    self.navView.backgroundColor = [UIColor colorWithHexString:navColor];
}

/**
 展示空页面
 */
-(void)showEmptyView {
    self.mainTableView.showEmptyView = YES;
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

-(void)leftBtnClick:(UIButton *)sender {
    NSArray *VCArr = self.navigationController.viewControllers;
    if (VCArr.count <= 0 ) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated: YES];
    }
}

#pragma mark:懒加载控件
-(UIButton *)leftBtn {
    if (!_leftBtn){
        _leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [_leftBtn setTitle:@"返回" forState:(UIControlStateNormal)];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_leftBtn setImage:[UIImage imageNamed:@"icon_back"] forState:(UIControlStateNormal)];
        [_leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _leftBtn;
}
-(UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _rightBtn;
}
-(UIButton *)righOthertBtn {
    if (!_righOthertBtn) {
        _righOthertBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _righOthertBtn;
}

/**
 tableview
 */
-(UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.backgroundColor = [UIColor clearColor];
        if ([self.navigationController.viewControllers indexOfObject:self] > 0) {
            _mainTableView.frame = CGRectMake(0, 0, kScreenw, kScreenH);
        } else {
            _mainTableView.frame = CGRectMake(0, NavBarHight, kScreenw, kScreenH - TabBarHeight - NavBarHight);
        }
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = [UIView new];
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
-(void)createBgview {
     self.view.backgroundColor = [UIColor colorWithHexString:@"#25B7FF"];
    for (NSInteger i = 0; i < 43; i++) {
        UIImageView *snowView =  [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ele_snow.png"]];
        snowView.tag = 1000+i;
        snowView.frame = CGRectMake( arc4random() % 300 * kWidth , arc4random() % 400, arc4random()%7+3, arc4random()%7+3);
        [self.view addSubview:snowView];
        [snowView.layer addAnimation:[self rainAnimationWithDuration:5+i%5] forKey:nil];
        [snowView.layer addAnimation:[self rainAlphaWithDuration:5+i%5] forKey:nil];
        [snowView.layer addAnimation:[self sunshineAnimationWithDuration:5] forKey:nil];
    }
    self.view.layer.speed = 1.0;
}

- (CABasicAnimation *)rainAnimationWithDuration:(NSInteger)duration{
    
    CABasicAnimation* caBaseTransform = [CABasicAnimation animation];
    caBaseTransform.duration = duration;
    caBaseTransform.keyPath = @"transform";
    caBaseTransform.repeatCount = MAXFLOAT;
    caBaseTransform.removedOnCompletion = NO;
    caBaseTransform.fillMode = kCAFillModeForwards;
    caBaseTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-170, -620, 0)];
    caBaseTransform.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(kScreenH/2.0*34/124.0, kScreenH/2, 0)];
    
    return caBaseTransform;
}
- (CABasicAnimation *)rainAlphaWithDuration:(NSInteger)duration {
    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:1.0];
    showViewAnn.toValue = [NSNumber numberWithFloat:0.1];
    showViewAnn.duration = duration;
    showViewAnn.repeatCount = MAXFLOAT;
    showViewAnn.fillMode = kCAFillModeForwards;
    showViewAnn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    showViewAnn.removedOnCompletion = NO;
    
    return showViewAnn;
}
- (CABasicAnimation *)sunshineAnimationWithDuration:(NSInteger)duration{
    
    CGFloat fromFloat = 0;
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:fromFloat * M_PI];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(fromFloat + 2.0 ) * M_PI];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = duration;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    return rotationAnimation;
}


@end
