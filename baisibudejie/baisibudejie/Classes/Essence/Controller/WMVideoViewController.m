//
//  WMVideoViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/18.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMVideoViewController.h"

@interface WMVideoViewController ()

@end

@implementation WMVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.确定重用标示:
    static NSString *ID = @"cell";
    
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = WMRandomColor;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd", [self class], indexPath.row];
    
    return cell;
    
}

@end
