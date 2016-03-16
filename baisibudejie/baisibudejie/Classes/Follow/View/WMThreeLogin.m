//
//  WMThreeLogin.m
//  baisibudejie
//
//  Created by hwm on 16/3/16.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMThreeLogin.h"
#import "WMQuickLoginButton.h"

@interface WMThreeLogin ()

@property (nonatomic, strong) WMQuickLoginButton *weiboBT;

@property (nonatomic, strong) WMQuickLoginButton *qqBT;

@property (nonatomic, strong) WMQuickLoginButton *xinlangBT;

@property (nonatomic, strong) UIImageView *leftImage;

@property (nonatomic, strong) UIImageView *rightImage;

@property (nonatomic, strong) UILabel *wm_lable;

@end

@implementation WMThreeLogin

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
//        self.backgroundColor = WMRandomColor;
        
        self.leftImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_register_left_line"]];
        [self addSubview:self.leftImage];
        
        self.rightImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_register_right_line"]];
        [self addSubview:self.rightImage];
        
        self.wm_lable = [[UILabel alloc] init];
        _wm_lable.text = @"快速登录";
        _wm_lable.textColor = [UIColor whiteColor];
        _wm_lable.font = [UIFont systemFontOfSize:17];
        _wm_lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.wm_lable];
        
        // 微博登录
        self.weiboBT = [WMQuickLoginButton buttonWithType:UIButtonTypeCustom];
        [_weiboBT setImage:[UIImage imageNamed:@"login_tecent_icon"] forState:UIControlStateNormal];
        [_weiboBT setImage:[UIImage imageNamed:@"login_tecent_icon_click"] forState:UIControlStateHighlighted];
        [_weiboBT setTitle:@"微博登录" forState:UIControlStateNormal];
        [self addSubview:_weiboBT];
        
        // qq登录
        self.qqBT = [WMQuickLoginButton buttonWithType:UIButtonTypeCustom];
        [_qqBT setImage:[UIImage imageNamed:@"login_QQ_icon"] forState:UIControlStateNormal];
        [_qqBT setImage:[UIImage imageNamed:@"login_QQ_icon_click"] forState:UIControlStateHighlighted];
        [_qqBT setTitle:@"QQ登录" forState:UIControlStateNormal];
        [self addSubview:_qqBT];
        // 新浪登录
        self.xinlangBT = [WMQuickLoginButton buttonWithType:UIButtonTypeCustom];
        [_xinlangBT setImage:[UIImage imageNamed:@"login_sina_icon"] forState:UIControlStateNormal];
        [_xinlangBT setImage:[UIImage imageNamed:@"login_sina_icon_click"] forState:UIControlStateHighlighted];
        [_xinlangBT setTitle:@"新浪登录" forState:UIControlStateNormal];
        [self addSubview:_xinlangBT];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonW = self.wm_width / 3;
    self.weiboBT.frame = CGRectMake(0, self.wm_height - buttonW - 35, buttonW, buttonW);
    
    self.qqBT.frame = CGRectMake(buttonW, self.wm_height - buttonW - 35, buttonW, buttonW);
    
    self.xinlangBT.frame = CGRectMake(buttonW * 2, self.wm_height - buttonW - 35, buttonW, buttonW);
    
    
    [self.wm_lable sizeToFit];
    self.wm_lable.center = CGPointMake(self.wm_centerX, 20);
    self.leftImage.frame = CGRectMake(20, self.wm_lable.wm_centerY, _wm_lable.wm_x - 30, 1);
    self.rightImage.frame = CGRectMake(_wm_lable.wm_right + 10, self.wm_lable.wm_centerY, _wm_lable.wm_x - 30, 1);;
    
}

@end
