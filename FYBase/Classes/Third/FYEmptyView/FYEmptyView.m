//
//  FYEmptyView.m
//  emptyView
//
//  Created by wang on 2018/7/31.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "FYEmptyView.h"


@implementation FYEmptyView

+(FYEmptyView *)initEmptyViewWithTitle:(NSString *)title imageName:(NSString *)imageName bounds:(CGRect)bounds backgroundColor:(UIColor *)backgroundColor {
    FYEmptyView *empty = [[FYEmptyView alloc] initWithFrame:bounds];
    empty.imageView.image = [UIImage imageNamed:imageName];
    empty.titleLabel.text = title;
    return empty;
}
+(FYEmptyView *)initEmptyViewWithTitle:(NSString *)title imageName:(NSString *)imageName bounds:(CGRect)bounds status:(FYEmptyViewStatus)status {
    FYEmptyView *empty = [[FYEmptyView alloc] initWithFrame:bounds];
    empty.imageView.image = [UIImage imageNamed:imageName];
    empty.titleLabel.text = title;
    empty.status = status;
    return empty;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //默认图片
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        self.imageView.center =  CGPointMake(self.center.x, self.center.y - 100);
        [self addSubview:self.imageView];
        self.imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptyImageClick:)];
        [self.imageView addGestureRecognizer:tap];
        //文字
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageView.frame) + 20, self.frame.size.width, 30)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#a2a2a2"];
        [self addSubview:_titleLabel];
    }
    return self;
}
-(void)setStatus:(FYEmptyViewStatus)status {
    _status = status;
    if (status == FYEmptyViewStatusAddress) {
    }
}

-(UIButton *)emptyBtn {
    if (!_emptyBtn) {
        _emptyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [self addSubview:_emptyBtn];
    }
    return _emptyBtn;
}

-(void)emptyImageClick:(UITapGestureRecognizer *)tap {
    if (self.emptyClickBlock) {
        self.emptyClickBlock();
    }
}






@end
