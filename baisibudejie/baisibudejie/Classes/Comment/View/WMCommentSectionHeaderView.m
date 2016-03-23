//
//  WMCommentSectionHeaderView.m
//  baisibudejie
//
//  Created by hwm on 16/3/23.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMCommentSectionHeaderView.h"

@implementation WMCommentSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor = [UIColor darkGrayColor];
        
        //        UISwitch *s = [[UISwitch alloc] init];
        //        s.xmg_x = 200;
        //        [self.contentView addSubview:s];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 在layoutSubviews方法中覆盖对子控件的一些设置
    self.textLabel.font = [UIFont systemFontOfSize:15];
    
    // 设置label的x值
    self.textLabel.wm_x = 5;
}

@end
