//
//  NSDate+WMExtension.h
//  baisibudejie
//
//  Created by hwm on 16/3/20.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WMExtension)

/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为明天
 */
- (BOOL)isTomorrow;

@end
