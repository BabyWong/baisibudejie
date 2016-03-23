//
//  WMExtension.m
//  baisibudejie
//
//  Created by hwm on 16/3/22.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMExtension.h"
#import "WMComment.h"

@implementation WMExtension

+(void)load {
    
    // 两层模型转换
    [WMTopic mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"top_cmt" : [WMComment class]};
    }];
    
    // 替换key
    [WMTopic mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"top_cmt" : @"top_cmt[0]",
                 @"small_image" : @"image0",
                 @"middle_image" : @"image2",
                 @"large_image" : @"image1"};}];
}

@end
