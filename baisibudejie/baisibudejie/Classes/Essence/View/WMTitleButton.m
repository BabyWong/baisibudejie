//
//  WMTitleButton.m
//  baisibudejie
//
//  Created by hwm on 16/3/18.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMTitleButton.h"

@implementation WMTitleButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {};

@end
