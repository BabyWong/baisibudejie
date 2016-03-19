//
//  WMAllViewController.m
//  baisibudejie
//
//  Created by hwm on 16/3/18.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMAllViewController.h"
#import "WMTopic.h"

@interface WMAllViewController ()

@property (nonatomic, strong) NSArray<WMTopic *> *topic; // 泛型

@end

@implementation WMAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
//    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    [self refresh];
    
}

- (void)refresh {
    
    UIRefreshControl *refrechC = [[UIRefreshControl alloc] init];
    [refrechC addTarget:self action:@selector(loadNews:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refrechC];
    
}

- (void)loadNews:(UIRefreshControl *)refreshC {
    
    // 加载数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    
    
    [[AFHTTPSessionManager manager] GET:CommenURL parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
//        [responseObject writeToFile:@"/Users/hwm/Desktop/topic.plist" atomically:YES];
        
        self.topic = [WMTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
     
                      
        // 刷新表格
        [self.tableView reloadData];
        
        // 让[刷新控件]结束刷新
        [refreshC endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        WMLog(@"请求失败");
        
        // 让[刷新控件]结束刷新
        [refreshC endRefreshing];
     
        
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
