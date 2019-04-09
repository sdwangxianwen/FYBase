//
//  UITableView+empety.m
//  emptyView
//
//  Created by wang on 2019/3/26.
//  Copyright © 2019 wang. All rights reserved.
//

#import "UITableView+empety.h"
#import "FYEmptyView.h"
#import <objc/runtime.h>

@implementation UITableView (empety)

/// exchange methods
+ (void)load{
    Method old = class_getInstanceMethod(self, @selector(reloadData));
    Method new = class_getInstanceMethod(self, @selector(fy_reloadData));
    method_exchangeImplementations(old, new);
}

-(void)setShowEmptyView:(BOOL)showEmptyView {
    objc_setAssociatedObject(self, @selector(showEmptyView), @(showEmptyView), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)showEmptyView{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

/// custom method
- (void)fy_reloadData {
    [self fy_reloadData];
    if (![self showEmptyView]) {
        return;
    }
    UIView *mmdView = nil;
    Class class = NSClassFromString(@"UITableViewWrapperView");
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:class]) {
            mmdView = view;
            break;
        }
    }
    if (!mmdView) {
        mmdView = self;
    }
    
    NSInteger totalRows = 0;
    totalRows = self.visibleCells.count;
    if (totalRows == 0) {
        for (NSInteger section = 0; section < self.numberOfSections; section++) {
            NSInteger rows = [self numberOfRowsInSection:section];
            totalRows += rows;
        }
    }
    
    if (totalRows > 0) {
        [mmdView.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull subview, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([subview isKindOfClass:[FYEmptyView class]]) {
                [subview removeFromSuperview];
                *stop = YES;
            }
        }];
        
    }else{
        FYEmptyView *emptyView = [[FYEmptyView alloc] init];
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(customEmptyView)]) {
            emptyView = [self.dataSource performSelector:@selector(customEmptyView)];
        }
        __weak typeof(emptyView) weakEmptyView = emptyView;
        emptyView.emptyClickBlock = ^{
            //图片的点击事件,重新加载
            if (self.delegate && [self.delegate respondsToSelector:@selector(emptyReloadData)]) {
                [self.delegate performSelector:@selector(emptyReloadData) withObject:weakEmptyView];
            }
        };
        [mmdView addSubview:emptyView];
    }
}

@end
