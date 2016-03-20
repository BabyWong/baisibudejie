//
//  WMRefreshFooter.m
//  baisibudejie
//
//  Created by hwm on 16/3/19.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMRefreshFooter.h"

@implementation WMRefreshFooter

- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textColor = [UIColor orangeColor];
    
    [self addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
    // 刷新控件出现一半就会进入刷新状态
    //    self.triggerAutomaticallyRefreshPercent = 0.5;
    
    // 不要自动刷新
    //    self.automaticallyRefresh = NO;
}

@end
