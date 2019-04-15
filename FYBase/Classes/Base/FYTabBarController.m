//
//  FYTabBarController.m
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#import "FYTabBarController.h"
#import "HomeViewController.h"

@interface FYTabBarController ()

@end

@implementation FYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addchildViewController];
    
}

-(void)addchildViewController {
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self addChildViewController:homeVC title:@"首页" image:@"" selectImage:@""];
}

-(void)addChildViewController:(UIViewController *)childController
                        title:(NSString *)title
                        image:(NSString *)image
                  selectImage:(NSString *)selectImage {
    FYNavgationController *nav = [[FYNavgationController alloc] initWithRootViewController:childController];
    nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[[UIImage imageNamed:selectImage] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]} forState:(UIControlStateNormal)];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:(UIControlStateSelected)];
    [self addChildViewController:nav];
}


@end
