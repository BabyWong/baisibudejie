//
//  WMSettingViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMSettingViewController.h"

@interface WMSettingViewController ()

@property (nonatomic, assign) unsigned long long size;

@end

@implementation WMSettingViewController

- (instancetype)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的设置";
    
    self.tableView.backgroundColor = WMCommonBgColor;
    
    // 计算文件总大小
    [self getCacheSize];
    
}

- (void)getCacheSize {
    
    // 总大小
//    unsigned long long size = 0;
    
    // 沙盒文件夹路径
    NSString *cachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *dirPath = [cachesPath stringByAppendingPathComponent:@"default"];
    
    // 文件管理者
    NSFileManager *manage = [NSFileManager defaultManager];
    
    // 文件夹中的所有文件
    NSArray *subPaths = [manage subpathsAtPath:dirPath];
    
    for (NSString *subPath in subPaths) {
        
        // 所有文件的路径
        NSString *fullSubPath = [dirPath stringByAppendingPathComponent:subPath];
        
        // 所有文件的总大小
        self.size += [manage attributesOfItemAtPath:fullSubPath error:nil].fileSize;
        
    }
    
    WMLog(@"%zd", self.size);
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *settingID = @"setting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:settingID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存%zd",self.size];
    
    return cell;
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
