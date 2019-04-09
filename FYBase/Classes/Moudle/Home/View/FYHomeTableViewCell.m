//
//  FYHomeTableViewCell.m
//  FYBase
//
//  Created by wang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

#import "FYHomeTableViewCell.h"

@implementation FYHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 100, 30)];
        self.label = label;
        [self.contentView addSubview:label];
        label.text = @"demo";
    }
    return self;
}

@end
