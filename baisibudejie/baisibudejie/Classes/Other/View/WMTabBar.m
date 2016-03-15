//
//  WMTabBar.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMTabBar.h"

@interface WMTabBar ()

@property (nonatomic, strong) UIButton *publishButton;

@end

@implementation WMTabBar

- (UIButton *)publishButton {
    
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_publishButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [_publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
 
        [self addSubview:_publishButton];
        
    }
    
    return _publishButton;
}



#pragma mark -- 点击更多
- (void)publishClick {
    
    WMLog(@"publish");
//    UIViewController *contro = [[UIViewController alloc] init];
//    contro.view.backgroundColor = [UIColor yellowColor];
    
//    [self presentViewController:contro animated:YES completion:nil];
    
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat buttonW = self.wm_width / 5;
    CGFloat buttonX = 0;
    NSInteger buttonIndex = 0;
    
    for (UIView *subView in self.subviews) {
        
        if (subView.class != NSClassFromString(@"UITabBarButton")) continue;
        
        buttonX = buttonIndex * buttonW;
        if (buttonIndex >= 2) {
            buttonX += buttonW;
        }
        
        subView.frame = CGRectMake(buttonX, 0, buttonW, self.wm_height);
        
        buttonIndex++;
    }
    self.publishButton.frame = CGRectMake(0, 0, buttonW, self.wm_height);
    self.publishButton.center = CGPointMake(self.wm_width / 2, self.wm_height / 2);
    
}

@end
