//
//  WMTopicViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/22.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMTopicViewController.h"
#import "WMTopic.h"
#import "WMRefreshHeader.h"
#import "WMRefreshFooter.h"
#import "WMAFHTTPSessionManager.h"
#import "WMTopicCell.h"
#import "WMNewViewController.h"

@interface WMTopicViewController ()

@property (nonatomic, strong) NSMutableArray<WMTopic *> *topic; // 泛型
/** 下拉刷新的提示文字 */
@property (nonatomic, weak) UILabel *label;
/** maxtime : 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
/** 任务管理者 */
@property (nonatomic, strong) WMAFHTTPSessionManager *manager;

/** 声明这个方法的目的 : 为了能够使用点语法的智能提示 */
- (NSString *)aParam;

@end

// 1.确定重用标示:
static NSString *topicID = @"topic";


@implementation WMTopicViewController
- (WMAFHTTPSessionManager *)manager {
    
    if (!_manager) {
        _manager = [WMAFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WMCommonBgColor;
    //    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self setUpRefresh];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WMTopicCell class]) bundle:nil] forCellReuseIdentifier:topicID];
    
    
    
}

- (void)setUpRefresh {
    
    self.tableView.mj_header = [WMRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNews)];
    
    
    // 一开始就刷新
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [WMRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    
}

- (WMTopicType)type {
    return 0;
}

//- (void)refresh {
//    UIRefreshControl *refrechC = [[UIRefreshControl alloc] init];
//    [refrechC addTarget:self action:@selector(loadNews:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:refrechC];
//}

- (NSString *)aParam {
    // 判断当前的控制器是不是新帖
    if (self.parentViewController.class == [WMNewViewController class]) {
        return @"newlist";
    }
    return @"list";
}

- (void)loadNews {
    
    // 取消所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // 加载数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    
    [self.manager GET:CommenURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        [responseObject writeToFile:@"/Users/hwm/Desktop/topic.plist" atomically:YES];
        
        // 存储maxtime(方便用来加载下一页数据)
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 字典数组 -> 模型数组
        self.topic = [WMTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        WMLog(@"请求失败");
        
        // 让[刷新控件]结束刷新
        [self.tableView.mj_header endRefreshing];
        
        
    }];
    
    
}

- (void)loadMoreTopics {
    
    
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    params[@"type"] = @(self.type);
    
    [self.manager GET:CommenURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典数组 -> 模型数组
        NSArray<WMTopic *> *moreTopic = [WMTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topic addObjectsFromArray:moreTopic];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        WMLog(@"请求失败 - %@", error);
        
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // 2.从缓存池中取
    WMTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicID];
    
    cell.topic = self.topic[indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.topic[indexPath.row].cellHeight;
}



@end
