//
//  WMLoginRegisterViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/16.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMLoginRegisterViewController.h"
#import "WMLoginRegister.h"
#import "WMThreeLogin.h"

@interface WMLoginRegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *registerBT;

@property (nonatomic, strong) WMLoginRegister *viewLogin;

@end

@implementation WMLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backGroudImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_register_background"]];
    backGroudImage.frame = self.view.frame;
    [self.view addSubview:backGroudImage];
    
    
    // cancelBT
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"login_close_icon"] forState:UIControlStateNormal];
    [backButton sizeToFit];
    backButton.center = CGPointMake(30, 50);
    [backButton addTarget:self action:@selector(close) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backButton];
    
    // register
    self.registerBT = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerBT setTitle:@"注册账号" forState:UIControlStateNormal];
    _registerBT.tintColor = [UIColor whiteColor];
    _registerBT.titleLabel.font = [UIFont systemFontOfSize:14];
    _registerBT.frame = CGRectMake(0, 0, 100, 50);
    _registerBT.center = CGPointMake(self.view.wm_width - 50, 50);
    [_registerBT addTarget:self action:@selector(showLoginOrRegister:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_registerBT];
    
    // account / passworld
    self.viewLogin = [[WMLoginRegister alloc] init];
    _viewLogin.frame = CGRectMake(0 , 0, 300, 250);
    _viewLogin.center = CGPointMake(self.view.wm_centerX, self.view.wm_centerY * 1.8/ 3);
    
    [_viewLogin.loginButton addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_viewLogin];
    

    // threeLogin
    WMThreeLogin *three = [[WMThreeLogin alloc] init];
    three.wm_bottom = self.view.wm_bottom;
    three.frame = CGRectMake(0, 0, self.view.wm_width, 220);
    three.center = CGPointMake(self.view.wm_centerX, self.view.wm_centerY * 1.7);
    [self.view addSubview:three];
}

- (void)loginClick:(UIButton *)button {
    
    WMLog(@"login");
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)showLoginOrRegister:(UIButton *)button {
    // 退出键盘
    [self.view endEditing:YES];
        
    // 设置约束 和 按钮状态
    if ([self.registerBT.titleLabel.text isEqualToString:@"注册账号"]) { // 目前显示的是注册界面, 点击按钮后要切换为登录界面
        [self.viewLogin.loginButton setTitle:@"注册" forState:UIControlStateNormal];
        _viewLogin.forgetButton.hidden = YES;
            [button setTitle:@"已有账号" forState:UIControlStateNormal];
    } else { // 目前显示的是登录界面, 点击按钮后要切换为注册界面
            [self.viewLogin.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _viewLogin.forgetButton.hidden = NO;
            [button setTitle:@"注册账号" forState:UIControlStateNormal];
    }
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        // 强制刷新 : 让最新设置的约束值马上应用到UI控件上
        // 会刷新到self.view内部的所有子控件
        [self.view layoutIfNeeded];
    }];
}

- (void)close {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
