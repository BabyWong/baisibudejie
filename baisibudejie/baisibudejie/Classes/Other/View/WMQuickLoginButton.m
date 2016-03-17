//
//  WMQuickLoginButton.m
//  baisibudejie
//
//  Created by hwm on 16/3/16.
//  Copyright © 2016年 hwm. All rights reserved.
//  图片在中间,文字在下面

#import "WMQuickLoginButton.h"

@implementation WMQuickLoginButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.wm_y = 0;
    self.imageView.wm_centerX = self.wm_width * 0.5;
    
    self.titleLabel.wm_x = 0;
    self.titleLabel.wm_y = self.imageView.wm_bottom;
    self.titleLabel.wm_height = self.wm_height - self.titleLabel.wm_y;
    self.titleLabel.wm_width = self.wm_width;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

@end
