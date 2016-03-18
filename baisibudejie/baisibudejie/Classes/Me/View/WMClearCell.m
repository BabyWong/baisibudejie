//
//  WMClearCell.m
//  baisibudejie
//
//  Created by hwm on 16/3/18.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMClearCell.h"
#import "NSString+WMExtence_FileSize.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

@implementation WMClearCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIActivityIndicatorView *load = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [load startAnimating];
        self.accessoryView = load;
        self.textLabel.text = @"清除缓存(正在计算缓存...)";
        
        // 禁止点击
        self.userInteractionEnabled = NO;
        
#pragma mark -- 避免block的强强引用
        __weak typeof(self) weakSelf = self;
        // 在子线程计算缓存
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            // 加延时器 测试
            [NSThread sleepForTimeInterval:2.0];
            
            // 获得缓存文件夹路径
            unsigned long long size = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"].fileSize;
            size += [SDImageCache sharedImageCache].getSize;
            
            // 如果cell已经销毁了, 就直接返回
            if (weakSelf == nil) return;
            
            NSString *sizeText = nil;
            
            // 设置文字
            if (size >= pow(10, 9)) { // size >= 1GB
                sizeText = [NSString stringWithFormat:@"%.2fGB", size / pow(10, 9)];
            } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
                sizeText = [NSString stringWithFormat:@"%.2fMB", size / pow(10, 6)];
            } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
                sizeText = [NSString stringWithFormat:@"%.2fKB", size / pow(10, 3)];
            } else { // 1KB > size
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
            // 生成文字
            NSString *text = [NSString stringWithFormat:@"清除缓存(%@)", sizeText];
            
            // 回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                // 设置文字
                weakSelf.textLabel.text = text;
                // 清空右边的指示器
                weakSelf.accessoryView = nil;
                // 显示右边的箭头
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                // 恢复点击事件
                weakSelf.userInteractionEnabled = YES;
                // 添加手势点击
                [weakSelf addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clearCache)]];
            });
            
        });
        
    }
    
    return self;
}

- (void)dealloc{
    WMLogFunc;
}

- (void)clearCache {
    
    // 弹窗
    [SVProgressHUD showWithStatus:@"正在清除缓存..." maskType:SVProgressHUDMaskTypeBlack];
    
    
    
#pragma mark -- 避免block的强强引用
    __weak typeof(self) weakSelf = self;
    
    // 删除SDWebImage的缓存
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager *manager = [NSFileManager defaultManager];
        [NSThread sleepForTimeInterval:2.0];
        // 删除自定义缓存
        [manager removeItemAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"] error:nil];
        // 创建自定义缓存
        [manager createDirectoryAtPath:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Custom"] withIntermediateDirectories:YES attributes:nil error:nil];
        
        // 所有的缓存都清除完毕
        dispatch_async(dispatch_get_main_queue(), ^{
            // 隐藏指示器
            [SVProgressHUD dismiss];
            weakSelf.textLabel.text = @"清除缓存(0B)";
        });
        
    });
    
}

/**
 *  当cell重新显示到屏幕上时, 也会调用一次layoutSubviews
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // cell重新显示的时候, 继续转圈圈
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}

@end
