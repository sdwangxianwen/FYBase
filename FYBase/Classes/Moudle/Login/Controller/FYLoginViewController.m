//
//  FYLoginViewController.m
//  FYBase
//
//  Created by wang on 2019/4/11.
//  Copyright © 2019 wang. All rights reserved.
//

#import "FYLoginViewController.h"
#import "FYLoginView.h"

@interface FYLoginViewController ()

@end

@implementation FYLoginViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.navTitle = @"登录";
    
    // Do any additional setup after loading the view.
}
-(void)setupUI {
    
    FYLoginView *loginView = [[FYLoginView alloc] initWithFrame:CGRectMake(0, 0, kScreenw, kScreenH)];
    [self.view addSubview:loginView];
}



@end
