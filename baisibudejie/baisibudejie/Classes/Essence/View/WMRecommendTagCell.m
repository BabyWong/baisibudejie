//
//  WMRecommendTagCell.m
//  baisibudejie
//
//  Created by hwm on 16/3/23.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMRecommendTagCell.h"
#import "WMRecommendTag.h"

@interface WMRecommendTagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageListView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation WMRecommendTagCell

- (void)setRecommendTag:(WMRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    // 头像
    [self.imageListView setHeader:recommendTag.image_list];
    
    // 名字
    self.themeNameLabel.text = recommendTag.theme_name;
    
    // 订阅数
    if (recommendTag.sub_number >= 10000) {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    } else {
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }
}

/**
 *  重写setFrame:的作用: 监听设置cell的frame的过程
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}


@end
