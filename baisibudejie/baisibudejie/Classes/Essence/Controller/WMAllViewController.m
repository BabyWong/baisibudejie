//
//  WMAllViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/18.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMAllViewController.h"
#import "WMTopic.h"
#import "WMRefreshHeader.h"
#import "WMRefreshFooter.h"

@interface WMAllViewController ()

@property (nonatomic, strong) NSMutableArray<WMTopic *> *topic; // 泛型
/** 下拉刷新的提示文字 */
@property (nonatomic, weak) UILabel *label;
/** maxtime : 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;

@end

@implementation WMAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
//    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
//    [self refresh];
    [self setUpRefresh];
    
}

- (void)setUpRefresh {
    
    self.tableView.mj_header = [WMRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNews)];
    self.tableView.mj_footer = [WMRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    
}

//- (void)refresh {
//    UIRefreshControl *refrechC = [[UIRefreshControl alloc] init];
//    [refrechC addTarget:self action:@selector(loadNews:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:refrechC];
//}

- (void)loadNews {
    
    // 加载数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    
    
    [[AFHTTPSessionManager manager] GET:CommenURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
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
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"maxtime"] = self.maxtime;
    
    [[AFHTTPSessionManager manager] GET:CommenURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
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
    // 1.确定重用标示:
    static NSString *ID = @"cell";
    
    // 2.从缓存池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 3.如果空就手动创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = WMRandomColor;
    }
    
    WMTopic *topic = self.topic[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;

}


@end
