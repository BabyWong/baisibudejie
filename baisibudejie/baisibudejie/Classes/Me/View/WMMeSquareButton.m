//
//  WMMeSquareButton.m
//  baisibudejie
//
//  Created by hwm on 16/3/17.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMMeSquareButton.h"
#import <UIButton+WebCache.h>

@implementation WMMeSquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.wm_y = self.wm_width * 0.15;
    self.imageView.wm_height = self.wm_height / 2;
    self.imageView.wm_width = self.imageView.wm_height;
    self.imageView.wm_centerX = self.wm_width / 2;
    
    self.titleLabel.wm_x = 0;
    self.titleLabel.wm_width = self.wm_width;
    self.titleLabel.wm_y = self.imageView.wm_bottom;
    self.titleLabel.wm_height = self.wm_height - self.titleLabel.wm_y;
}

- (void)setSquares:(WMMeSquare *)squares {
    
    _squares = squares;
    
    [self setTitle:_squares.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:_squares.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
    
}

@end
