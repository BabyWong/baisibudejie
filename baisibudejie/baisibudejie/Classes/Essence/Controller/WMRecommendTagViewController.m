//
//  WMRecommendTagViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/23.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMRecommendTagViewController.h"
#import "WMRecommendTag.h"
#import "WMAFHTTPSessionManager.h"
#import "WMRecommendTagCell.h"
#import <SVProgressHUD.h>

@interface WMRecommendTagViewController ()
/** 所有的标签数据(数组中存放的都是WMRecommendTag模型) */
@property (nonatomic, strong) NSArray<WMRecommendTag *> *recommendTags;
/** 请求管理者 */
@property (nonatomic, weak) WMAFHTTPSessionManager *manager;
@end

@implementation WMRecommendTagViewController

/** manager属性的懒加载 */
- (WMAFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [WMAFHTTPSessionManager manager];
    }
    return _manager;
}

/** cell的重用标识 */
static NSString * const WMRecommendTagCellId = @"recommendTag";

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    self.navigationItem.title = @"推荐标签";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WMRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:WMRecommendTagCellId];
    self.tableView.rowHeight = 70;
    self.tableView.backgroundColor = WMCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 加载标签数据
    [self loadNewRecommandTags];
}

/**
 *  加载标签数据
 */
- (void)loadNewRecommandTags
{
    [SVProgressHUD show];
    
    __weak typeof(self) weakSelf = self;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // 发送请求
    [self.manager GET:CommenURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        // 字典数组 -> 模型数组
        weakSelf.recommendTags = [WMRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        // 刷新
        [weakSelf.tableView reloadData];
        
        // 去除HUD
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        // 如果是取消任务, 就直接返回
        if (error.code == NSURLErrorCancelled) return;
        
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络繁忙, 请稍后再试"];
    }];
}

/**
 *  当控制器的view即将消失的时候调用
 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 隐藏HUD
    [SVProgressHUD dismiss];
    
    // 取消请求
    // [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recommendTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:WMRecommendTagCellId];
    
    cell.recommendTag = self.recommendTags[indexPath.row];
    
    return cell;
}
@end
