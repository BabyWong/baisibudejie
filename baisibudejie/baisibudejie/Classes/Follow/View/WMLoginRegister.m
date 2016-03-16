//
//  WMLoginRegister.m
//  baisibudejie
//
//  Created by hwm on 16/3/16.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMLoginRegister.h"

@interface WMLoginRegister ()

@property (nonatomic, strong) UITextField *accountTextField;

@property (nonatomic, strong) UITextField *passwordTextField;



@end

@implementation WMLoginRegister


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        // account
        self.accountTextField = [[UITextField alloc] init];
        [_accountTextField sizeToFit];
        _accountTextField.placeholder = @"手机号";
        _accountTextField.tintColor = [UIColor whiteColor];
        _accountTextField.font = [UIFont systemFontOfSize:16];
        _accountTextField.borderStyle = UITextBorderStyleRoundedRect;
        _accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _accountTextField.keyboardType = UIKeyboardTypeNumberPad;
        _accountTextField.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:_accountTextField];
        
        // password
        self.passwordTextField = [[UITextField alloc] init];
        [_passwordTextField sizeToFit];
        _passwordTextField.placeholder = @"密码";
        _passwordTextField.tintColor = [UIColor whiteColor];
        _passwordTextField.font = [UIFont systemFontOfSize:16];
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.keyboardType = UIKeyboardTypeDefault;
        _passwordTextField.backgroundColor = [UIColor darkGrayColor];
        _passwordTextField.clearsOnBeginEditing = YES;
        [self addSubview:_passwordTextField];
        
        
        // login/registe按钮
        self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:@"loginBtnBg"];
        /************* iOS5.0前 ****************/
        //    NSInteger leftCapWidth = image.size.width * 0.5f;
        //    NSInteger topCapHeight = image.size.height * 0.5f;
        //    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
        /************* 后 ****************/
        CGFloat top = 25; // 顶端盖高度
        CGFloat bottom = 25 ; // 底端盖高度
        CGFloat left = 10; // 左端盖宽度
        CGFloat right = 10; // 右端盖宽度
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        // 指定为拉伸模式，伸缩后重新赋值
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        [_loginButton setBackgroundImage:image forState:UIControlStateNormal];
        _loginButton.layer.cornerRadius = 5;
        _loginButton.clipsToBounds = YES;
        [_loginButton addTarget:self action:@selector(loginRegisteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_loginButton];
        
    }
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.accountTextField.frame = CGRectMake(0, 0, 250, 60);
    self.accountTextField.center = CGPointMake(self.wm_width / 2, self.wm_height * 1 / 3);
    
    self.passwordTextField.frame = CGRectMake(0, 0, 250, 45);
    self.passwordTextField.center = CGPointMake(self.wm_width / 2, self.wm_height * 1.5 / 3);
    
    _loginButton.frame = CGRectMake(0, 0, 250, 40);
    _loginButton.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height * 2.2 / 3);

}

@end