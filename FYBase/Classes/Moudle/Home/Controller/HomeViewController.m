//
//  HomeViewController.m
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#import "HomeViewController.h"
#import "FYHomeTableViewCell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController



-(void)configureCell:(FYHomeTableViewCell *)cell item:(NSString *)item {
    cell.label.text = item;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FYBaseViewController *baseVC = [[FYBaseViewController alloc] init];
    [self.navigationController pushViewController:baseVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isGroup = YES;
    self.cellID = @"FYHomeTableViewCell";
    self.listArrM = @[@[@"1",@"2"],@[@"3",@"4"]].mutableCopy;
    [self.view addSubview:self.mainTableView];
}




@end
