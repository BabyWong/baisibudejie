//
//  UIView+WMExtension.m
//  baisibudejie
//
//  Created by hwm on 16/3/15.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "UIView+WMExtension.h"

@implementation UIView (WMExtension)


- (CGFloat)wm_width
{
    return self.frame.size.width;
}

- (CGFloat)wm_height
{
    return self.frame.size.height;
}

- (void)setWm_width:(CGFloat)wm_width
{
    CGRect frame = self.frame;
    frame.size.width = wm_width;
    self.frame = frame;
}

- (void)setWm_height:(CGFloat)wm_height
{
    CGRect frame = self.frame;
    frame.size.height = wm_height;
    self.frame = frame;
}

- (CGFloat)wm_x
{
    return self.frame.origin.x;
}

- (void)setWm_x:(CGFloat)wm_x
{
    CGRect frame = self.frame;
    frame.origin.x = wm_x;
    self.frame = frame;
}

- (CGFloat)wm_y
{
    return self.frame.origin.y;
}

- (void)setWm_y:(CGFloat)wm_y
{
    CGRect frame = self.frame;
    frame.origin.y = wm_y;
    self.frame = frame;
}

- (CGFloat)wm_centerX
{
    return self.center.x;
}

- (void)setWm_centerX:(CGFloat)wm_centerX
{
    CGPoint center = self.center;
    center.x = wm_centerX;
    self.center = center;
}

- (CGFloat)wm_centerY
{
    return self.center.y;
}

- (void)setWm_centerY:(CGFloat)wm_centerY
{
    CGPoint center = self.center;
    center.y = wm_centerY;
    self.center = center;
}

- (CGFloat)wm_right
{
    //    return self.wm_x + self.wm_width;
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)wm_bottom
{
    //    return self.wm_y + self.wm_height;
    return CGRectGetMaxY(self.frame);
}

- (void)setWm_right:(CGFloat)wm_right
{
    self.wm_x = wm_right - self.wm_width;
}

- (void)setWm_bottom:(CGFloat)wm_bottom
{
    self.wm_y = wm_bottom - self.wm_height;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


@end
