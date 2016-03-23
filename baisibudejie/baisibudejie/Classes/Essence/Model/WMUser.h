//
//  WMUser.h
//  baisibudejie
//
//  Created by hwm on 16/3/21.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMUser : NSObject

/* 用户 */
@property (nonatomic, strong) NSString *username;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 性别 m(male) f(female) */
@property (nonatomic, copy) NSString *sex;

@end
