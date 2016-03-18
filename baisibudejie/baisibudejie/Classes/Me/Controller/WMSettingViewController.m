//
//  WMSettingViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMSettingViewController.h"
#import "NSString+WMExtence_FileSize.h"
#import <SDImageCache.h>
#import "WMClearCell.h"
#import "WMOtherCell.h"

@interface WMSettingViewController ()

@end

@implementation WMSettingViewController

static NSString * const WMClearCacheCellId = @"WMClearCell";
static NSString * const WMSettingCellId = @"WMSettingCell";
static NSString * const WMOtherCellId = @"WMOtherCell";

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的设置";
    
    self.tableView.backgroundColor = WMCommonBgColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    // 计算文件总大小
//    [self getCacheSize];
    
    // 注册
    [self.tableView registerClass:[WMClearCell class] forCellReuseIdentifier:WMClearCacheCellId];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:WMSettingCellId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WMOtherCell class]) bundle:nil] forCellReuseIdentifier:WMOtherCellId];
    
}

// 计算缓存大小
//- (void)getCacheSize {
//    // 总大小
////    unsigned long long size = 0;
//    
//    // 沙盒文件夹路径
//    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
//    
//    NSString *dirPath = [cachesPath stringByAppendingPathComponent:@"default"];
//    
//    // 文件管理者
//    NSFileManager *manage = [NSFileManager defaultManager];
//    
//    // 文件夹中的所有文件
//    NSArray *subPaths = [manage subpathsAtPath:dirPath];
//    
//    for (NSString *subPath in subPaths) {
//        
//        // 所有文件的路径
//        NSString *fullSubPath = [dirPath stringByAppendingPathComponent:subPath];
//        
//        // 所有文件的总大小
//        self.size += [manage attributesOfItemAtPath:fullSubPath error:nil].fileSize;
//    }
//    WMLog(@"%zd", self.size);
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 10;
    }
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 清除缓存cell
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        return [tableView dequeueReusableCellWithIdentifier:WMClearCacheCellId];
    
    }else if (indexPath.row == 2) {

        
        return [tableView dequeueReusableCellWithIdentifier:WMOtherCellId];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:WMSettingCellId];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd - %zd", indexPath.section, indexPath.row];
    
        return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[WMOtherCell class]]) {
        
        WMLog(@"click othercell");
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
