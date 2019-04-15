//
//  HomeViewController.m
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#import "HomeViewController.h"
#import "FYHomeTableViewCell.h"
#import "FYLoginViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)configureCell:(FYHomeTableViewCell *)cell item:(NSString *)item {
    cell.label.text = item;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FYLoginViewController *baseVC = [[FYLoginViewController alloc] init];
    [self.navigationController pushViewController:baseVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isGroup = YES;
    self.cellID = @"FYHomeTableViewCell";
    self.listArrM = @[@[@"1",@"2"],@[@"3",@"4"]].mutableCopy;
    [self initMainTableView];
    self.mainTableView.frame = CGRectMake(0, 0, kScreenw, kScreenH - TabBarHeight);
    self.mainTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenw, 200)];
    self.mainTableView.tableHeaderView.backgroundColor = [UIColor brownColor];
    self.mainTableView.rowHeight = 200;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > StatusBarHeight) {
        CGFloat alpha = MIN(1,1 - ((NavBarHight - scrollView.contentOffset.y) / NavBarHight));
        self.navView.hidden = NO;
        self.navView.alpha = alpha;
        self.navTitle = @"首页";
        self.navColor = @"#25B7FF";
        
    } else {
         self.navView.hidden = YES;
    }
}



@end
