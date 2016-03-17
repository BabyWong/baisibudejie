//
//  WMMeCell.m
//  baisibudejie
//
//  Created by hwm on 16/3/17.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMMeCell.h"

@implementation WMMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    
    return self;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;// 没有图片
    
    CGFloat margin = 10;
//    self.imageView.wm_x = margin;
    self.imageView.wm_height = self.wm_height - 2 * margin;
    self.imageView.wm_width = self.imageView.wm_height;
    self.imageView.wm_y = margin;
    
    self.textLabel.wm_x = self.imageView.wm_right + margin;
    
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
