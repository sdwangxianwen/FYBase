//
//  FYCustomNavView.m
//  FYBase
//
//  Created by wang on 2019/4/15.
//  Copyright © 2019 wang. All rights reserved.
//

#import "FYCustomNavView.h"

@implementation FYCustomNavView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self titleLabel];
    }
    return self;
}

-(void)leftBtnClick:(UIButton *)sender {
    [[self getCurrentViewController].navigationController popViewControllerAnimated: YES];
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70*kWidth, StatusBarHeight, kScreenw - (140)*kWidth, 44)];
        [self addSubview:_titleLabel];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}




@end


