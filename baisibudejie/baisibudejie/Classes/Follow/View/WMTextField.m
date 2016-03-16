//
//  WMTextField.m
//  baisibudejie
//
//  Created by hwm on 16/3/16.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMTextField.h"

static NSString * const WMPlaceholderColorKey = @"placeholderLabel.textColor";

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
        
        self.backgroundColor = [UIColor darkGrayColor];
        self.tintColor = [UIColor whiteColor];
        self.borderStyle = UITextBorderStyleNone;
        self.layer.cornerRadius = 6;
        self.clipsToBounds = YES;
        self.textColor = [UIColor whiteColor];
        
        // 监听文本框变化
        [self addTarget:self action:@selector(editingDiBegin) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self action:@selector(editingDiend) forControlEvents:UIControlEventEditingDidEnd];
    }
    return self;
}


- (void)editingDiBegin {

    [self setValue:[UIColor whiteColor] forKeyPath:WMPlaceholderColorKey];
}

- (void)editingDiend {

    [self setValue:[UIColor grayColor] forKeyPath:WMPlaceholderColorKey];
}


// 控制 编辑光标和编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    
    CGRect inset = CGRectMake(bounds.origin.x + 8, bounds.origin.y, bounds.size.width - 8, bounds.size.height);
    return inset;
}

// 控制 显示光标和编辑文本的位置
- (CGRect)textRectForBounds:(CGRect)bounds {
     return CGRectInset( bounds, 8 , 0 );
}

//控制placeHolder的位置，左右缩20
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    
    

    return CGRectInset(bounds, 8, 0);
//    CGRect inset = CGRectMake(bounds.origin.x+50, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
//    return inset;
}

@end
