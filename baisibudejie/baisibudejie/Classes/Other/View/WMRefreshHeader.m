//
//  WMRefreshHeader.m
//  baisibudejie
//
//  Created by hwm on 16/3/19.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMRefreshHeader.h"

@interface WMRefreshHeader ()

/** logo */
@property (nonatomic, weak) UIImageView *logo;

@end

@implementation WMRefreshHeader

/**
 *  初始化
 */
- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    self.lastUpdatedTimeLabel.textColor = [UIColor orangeColor];
    self.stateLabel.textColor = [UIColor orangeColor];
    [self setTitle:@"赶紧下拉吧" forState:MJRefreshStateIdle];
    [self setTitle:@"赶紧松开吧" forState:MJRefreshStatePulling];
    [self setTitle:@"正在加载数据..." forState:MJRefreshStateRefreshing];
    //    self.lastUpdatedTimeLabel.hidden = YES;
    //    self.stateLabel.hidden = YES;
    [self addSubview:[[UISwitch alloc] init]];
    
    UIImageView *logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"me.jpeg"];
    [self addSubview:logo];
    self.logo = logo;
}


/**
 *  摆放子控件
 */
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.logo.wm_width = self.wm_width;
    self.logo.wm_height = 70;
    self.logo.wm_x = 0;
    self.logo.wm_y = - 50;
}

@end
