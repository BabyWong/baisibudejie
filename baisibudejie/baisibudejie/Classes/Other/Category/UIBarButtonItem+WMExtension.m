//
//  UIBarButtonItem+WMExtension.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "UIBarButtonItem+WMExtension.h"

@implementation UIBarButtonItem (WMExtension)

+ (instancetype)itemWithImage:(NSString *)image selectImage:(NSString *)selectImage targe:(id)targe action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    [button addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    // 自适应
    [button sizeToFit];
    return [[self alloc] initWithCustomView:button];
}

@end
