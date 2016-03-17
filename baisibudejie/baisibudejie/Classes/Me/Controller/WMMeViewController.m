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


- (instancetype)init {
    
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我";
    
    UIBarButtonItem *moon = [UIBarButtonItem itemWithImage:@"mine-moon-icon" selectImage:@"mine-moon-icon-click" targe:self action:@selector(moonClick)];
    UIBarButtonItem *setting = [UIBarButtonItem itemWithImage:@"mine-setting-icon" selectImage:@"mine-setting-icon-click" targe:self action:@selector(settingClick)];
    self.navigationItem.rightBarButtonItems = @[setting, moon];
    
    self.view.backgroundColor = WMCommonBgColor;
//    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:meID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:meID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine-my-post"];
        cell.textLabel.text = @"我的";
    }else {
        cell.textLabel.text = @"离线下载";
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return 44;
    }
    
    return 200;
}


@end
