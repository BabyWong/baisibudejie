//
//  NSCalendar+WMExtension.m
//  baisibudejie
//
//  Created by hwm on 16/3/20.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "NSCalendar+WMExtension.h"

@implementation NSCalendar (WMExtension)

+ (instancetype)calendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }else {
        return [NSCalendar currentCalendar];
    }
}

@end
