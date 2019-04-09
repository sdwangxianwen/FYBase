//
//  UITableView+empety.h
//  emptyView
//
//  Created by wang on 2019/3/26.
//  Copyright © 2019 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FYEmptyView;
@protocol UITableViewEmpetyDelegate <NSObject>

@optional

-(void)emptyReloadData; //重新加载
-(FYEmptyView *)customEmptyView;

@end

@interface UITableView (empety)
/**
 是否显示空数据，默认为NO
 */
@property (nonatomic,  assign) BOOL  showEmptyView;
@end

NS_ASSUME_NONNULL_END
