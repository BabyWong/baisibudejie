//
//  WMFollowViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMFollowViewController.h"
#import "WMRecommenViewController.h"
#import "WMLoginRegisterViewController.h"

@interface WMFollowViewController ()

@end

@implementation WMFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" selectImage:@"friendsRecommentIcon-click" targe:self action:@selector(recommenClick)];
    
    // 头像
    UIImageView *iconImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_cry_icon"]];
//    iconImage.frame = CGRectMake(0, 0, 35, 35);
    [iconImage sizeToFit];
    iconImage.center = CGPointMake(self.view.wm_width / 2, self.view.wm_height / 3);
    [self.view addSubview:iconImage];
    
    // account
    UITextField *accountTextField = [[UITextField alloc] init];
    [accountTextField sizeToFit];
    accountTextField.placeholder = @"请输入手机号";
    accountTextField.font = [UIFont systemFontOfSize:16];
    accountTextField.borderStyle = UITextBorderStyleRoundedRect;
    accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    accountTextField.frame = CGRectMake(0, 0, 250, 40);
    accountTextField.center = CGPointMake(self.view.wm_width / 2, self.view.wm_height * 1.4 / 3);
    [self.view addSubview:accountTextField];

    // password
    UITextField *passwordTextField = [[UITextField alloc] init];
    [passwordTextField sizeToFit];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.font = [UIFont systemFontOfSize:16];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.frame = CGRectMake(0, 0, 250, 40);
    passwordTextField.center = CGPointMake(self.view.wm_width / 2, self.view.wm_height * 1.6 / 3);
    [self.view addSubview:passwordTextField];
    
    
    // login/registe按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [loginButton setTitle:@"立即登录注册" forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login_click"] forState:UIControlStateHighlighted];
    loginButton.layer.cornerRadius = 7;
    loginButton.clipsToBounds = YES;
    [loginButton addTarget:self action:@selector(loginRegisteClick) forControlEvents:UIControlEventTouchUpInside];
    [loginButton sizeToFit];
    loginButton.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height * 2 / 3);
    [self.view addSubview:loginButton];

    
}

- (void)loginRegisteClick {
    
    [self presentViewController:[[WMLoginRegisterViewController alloc] init] animated:YES completion:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)recommenClick {
    
    [self.navigationController pushViewController:[[WMRecommenViewController alloc] init] animated:YES];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
