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
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:image];
    childController.tabBarItem.selectedImage =[UIImage imageNamed:selectImage];
    FYNavgationController *nav = [[FYNavgationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}


@end
