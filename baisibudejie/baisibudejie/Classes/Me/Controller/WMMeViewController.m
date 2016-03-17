//
//  WMMeViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMMeViewController.h"
#import "WMSettingViewController.h"
#import "WMMeCell.h"
#import "WMMeFooterView.h"

@interface WMMeViewController ()

@end

@implementation WMMeViewController


- (instancetype)init {
    
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我";
    
    UIBarButtonItem *moon = [UIBarButtonItem itemWithImage:@"mine-moon-icon" selectImage:@"mine-moon-icon-click" targe:self action:@selector(moonClick)];
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:@"mine-setting-icon" selectImage:@"mine-setting-icon-click" targe:self action:@selector(settingClick)];
    self.navigationItem.rightBarButtonItems = @[setting, moon];
    
    self.tableView.backgroundColor = WMCommonBgColor;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    self.tableView.tableFooterView = [[WMMeFooterView alloc] init];
   
}

- (void)moonClick {
    
    WMLog(@"menu");
    
}

- (void)settingClick {
    
    [self.navigationController pushViewController:[[WMSettingViewController alloc] init] animated:YES];
    
}

#pragma mark -- datesour
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *meID = @"me";
    WMMeCell *cell = [tableView dequeueReusableCellWithIdentifier:meID];
    if (!cell) {
        cell = [[WMMeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:meID];
    }
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
        cell.textLabel.text = @"登录注册";
    }else {
        cell.textLabel.text = @"离线下载";
        // 只要有其他cell设置过imageView.image, 其他不显示图片的cell都需要设置imageView.image = nil
        cell.imageView.image = nil;
    }
    
    return cell;
}



@end
