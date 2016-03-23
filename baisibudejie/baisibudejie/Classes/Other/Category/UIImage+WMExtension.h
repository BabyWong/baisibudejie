//
//  UIImage+WMExtension.h
//  baisibudejie
//
//  Created by hwm on 16/3/23.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WMExtension)
/**
 *  返回圆形图片
 */
- (instancetype)circleImage;

+ (instancetype)circleImage:(NSString *)name;
@end
