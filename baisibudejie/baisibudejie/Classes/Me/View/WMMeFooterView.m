//
//  WMMeFooterView.m
//  baisibudejie
//
//  Created by hwm on 16/3/17.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMMeFooterView.h"
#import <AFNetworking.h>
#import "WMMeSquare.h"
#import <MJExtension.h>
#import <UIButton+WebCache.h>
#import "WMMeSquareButton.h"
#import "WMWebViewController.h"

@implementation WMMeFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        
        // 请求
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {// 请求成功
            
#warning // Json转Data
            
            
//            // 写入plish文件
//            [responseObject writeToFile:@"/Users/hwm/Desktop/square.plist" atomically:YES];
            
            // 字典数组 - 转 - 模型数组
            NSArray *squares = [WMMeSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            // 拿到模型数据 做事情
            [self creatSquare:squares];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {// 请求失败
            
            WMLog(@"请求失败");
            
        }];
         
    }
    return self;
}

/**
 *  根据模型数据创建对应的控件
 */
- (void)creatSquare:(NSArray *)squares {
    
    // 方块的个数
    NSUInteger count = squares.count;
    
    // 方块的尺寸
    int maxColsCount = 4; // 一行的最大列数
    CGFloat buttonW = self.wm_width / maxColsCount;
    CGFloat buttonH = buttonW;
    
    // 创建所有的方块
    for (NSUInteger i = 0; i < count; i++) {
        // i位置对应的第i行模型数据(即第i行字典数组)
        WMMeSquare *square = squares[i];
        
        // 创建按钮
        WMMeSquareButton *button = [WMMeSquareButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 设置frame
        button.wm_x = (i % maxColsCount) * buttonW;// (第i个 % 最大列数) * 按钮宽度
        button.wm_y = (i / maxColsCount) * buttonH;// (第i个 / 最大列数) * 按钮高度
        button.wm_width = buttonW;
        button.wm_height = buttonH;
       
        // 设置数据
        button.squares = square;

    }
    
     // 设置footer的高度 == 最后一个按钮的bottom(最大Y值)
    self.wm_height = self.subviews.lastObject.wm_bottom;
    
    UITableView *tableview = (UITableView *)self.superview;
    tableview.tableFooterView = self;
    [tableview reloadData]; // 重新刷新数据(会重新计算contentSize)    
    
}

- (void)buttonClick:(WMMeSquareButton *)button {
    
    
    WMMeSquare *square = button.squares;
    NSString *url = square.url;
    
    if ([square.url hasPrefix:@"http"]) { // 利用webView加载url即可
        WMLog(@"利用webView加载url");
        
        // 获得"我"模块对应的导航控制器
        UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
        UINavigationController *nav = tabBar.selectedViewController;
        WMWebViewController *web = [[WMWebViewController alloc] init];
        web.url = url;
        web.navigationItem.title = button.currentTitle;
        [nav pushViewController:web animated:YES];
        
    } else if ([square.url hasPrefix:@"mod"]) { // 另行处理
        if ([square.url hasSuffix:@"BDJ_To_Check"]) {
            WMLog(@"跳转到[审帖]界面");
        } else if ([square.url hasSuffix:@"BDJ_To_RecentHot"]) {
            WMLog(@"跳转到[每日排行]界面");
        } else {
            WMLog(@"跳转到其他界面");
        }
    } else {
        WMLog(@"不是http或者mod协议的");
    }
    
}

@end
