//
//  WMTopicViewController.h
//  baisibudejie
//
//  Created by hwm on 16/3/22.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMTopic.h"


@interface WMTopicViewController : UITableViewController

/** 帖子的类型 */
@property (nonatomic, assign) WMTopicType type;

@end
