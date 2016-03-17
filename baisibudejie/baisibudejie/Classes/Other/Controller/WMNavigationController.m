//
//  WMNavigationController.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMNavigationController.h"

@interface WMNavigationController () <UIGestureRecognizerDelegate>

@end

@implementation WMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 拦截所有push的控件
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 统一设置返回键
    if (self.childViewControllers.count > 0) {
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 隐藏底部的工具条
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    
    // 所有设置搞定后, 再push控制器
    [super pushViewController:viewController animated:YES];
    
}

- (void)back {
    
    [self popViewControllerAnimated:YES];
}

#pragma mark -- delegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

@end
