//
//  UIView+WMExtension.h
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WMExtension)

@property (nonatomic, assign) CGFloat wm_width;
@property (nonatomic, assign) CGFloat wm_height;
@property (nonatomic, assign) CGFloat wm_x;
@property (nonatomic, assign) CGFloat wm_y;
@property (nonatomic, assign) CGFloat wm_centerX;
@property (nonatomic, assign) CGFloat wm_centerY;

@property (nonatomic, assign) CGFloat wm_right;
@property (nonatomic, assign) CGFloat wm_bottom;

+ (instancetype)viewFromXib;

@end
