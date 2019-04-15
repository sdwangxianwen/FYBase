//
//  FYCustomNavView.h
//  FYBase
//
//  Created by wang on 2019/4/15.
//  Copyright © 2019 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,FYNavTitleViewType) {
    FYNavTitleViewTypeTitle,
    FYNavTitleViewTypeSearch
};

@interface FYCustomNavView : UIView
@property (nonatomic, strong)UILabel *titleLabel;
@property(nonatomic,assign)FYNavTitleViewType type;
@end



NS_ASSUME_NONNULL_END
