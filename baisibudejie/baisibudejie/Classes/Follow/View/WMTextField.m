//
//  WMTextField.m
//  baisibudejie
//
//  Created by hwm on 16/3/16.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMTextField.h"

@implementation WMTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

// 控制光标和编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    
    CGRect inset = CGRectMake(bounds.origin.x + 8, bounds.origin.y, bounds.size.width - 8, bounds.size.height);
    return inset;
}

//控制placeHolder的位置，左右缩20
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    
    

    return CGRectInset(bounds, 8, 0);
//    CGRect inset = CGRectMake(bounds.origin.x+50, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
//    return inset;
}

@end
