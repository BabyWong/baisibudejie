//
//  UIBarButtonItem+WMExtension.h
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//  返回有状态的图片按钮

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WMExtension)

+ (instancetype)itemWithImage:(NSString *)image selectImage:(NSString *)selectImage targe:(id)targe action:(SEL)action;

@end
