//
//  WMComment.h
//  baisibudejie
//
//  Created by hwm on 16/3/21.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WMUser;

@interface WMComment : NSObject

/* 用户 */
@property (nonatomic, strong) WMUser *user;
/* 内容 */
@property (nonatomic, copy) NSString *content;

@end
