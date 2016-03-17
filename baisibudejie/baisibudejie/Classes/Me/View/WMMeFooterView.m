//
//  WMMeFooterView.m
//  baisibudejie
//
//  Created by hwm on 16/3/17.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMMeFooterView.h"
#import "WMQuickLoginButton.h"
#import <AFNetworking.h>
#import "WMMeSquare.h"
#import <MJExtension.h>
#import <UIButton+WebCache.h>

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
        WMQuickLoginButton *button = [WMQuickLoginButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        // 设置frame
        button.wm_x = (i % maxColsCount) * buttonW;// (第i个 % 最大列数) * 按钮宽度
        button.wm_y = (i / maxColsCount) * buttonH;// (第i个 / 最大列数) * 按钮高度
        button.wm_width = buttonW;
        button.wm_height = buttonH;
        
        // 设置数据
//        button.backgroundColor = WMRandomColor;
        [button setTitle:square.name forState:UIControlStateNormal];
        [button sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"setup-head-default"]];
    }
    
}

- (void)buttonClick:(UIButton *)button {
    
    
    
}

@end
