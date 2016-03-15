//
//  WMMeViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMMeViewController.h"
#import "WMSettingViewController.h"

@interface WMMeViewController ()

@end

@implementation WMMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我";
    
    UIBarButtonItem *moon = [UIBarButtonItem itemWithImage:@"mine-moon-icon" selectImage:@"mine-moon-icon-click" targe:self action:@selector(moonClick)];
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:@"mine-setting-icon" selectImage:@"mine-setting-icon-click" targe:self action:@selector(settingClick)];
    self.navigationItem.rightBarButtonItems = @[setting, moon];
    
    
}

- (void)moonClick {
    
    WMLog(@"menu");
    
}

- (void)settingClick {
    
    [self.navigationController pushViewController:[[WMSettingViewController alloc] init] animated:YES];
    
}



@end
