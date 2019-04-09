//
//  AppDelegate.h
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYGestureBaseController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) gestureBaseView *gestureBaseView;
@property (strong, nonatomic) UIWindow *window;
+ (AppDelegate* )shareAppDelegate;
- (void)setupRootViewController:(UIViewController *)rootViewController;

@end

