//
//  WMCommentCell.m
//  baisibudejie
//
//  Created by hwm on 16/3/23.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMCommentCell.h"
#import "WMComment.h"
#import "WMUser.h"

@interface WMCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation WMCommentCell

- (void)awakeFromNib {
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
}

- (void)setComment:(WMComment *)comment
{
    _comment = comment;
    
    self.usernameLabel.text = comment.user.username;
    self.contentLabel.text = comment.content;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    [self.profileImageView setHeader:comment.user.profile_image];
    
    NSString *sexImageName = [comment.user.sex isEqualToString:WMUserSexMale] ? @"Profile_manIcon" : @"Profile_womanIcon";
    self.sexView.image =  [UIImage imageNamed:sexImageName];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
