//
//  WMTopicCell.m
//  baisibudejie
//
//  Created by hwm on 16/3/20.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMTopicCell.h"
#import "WMTopicVideoView.h"
#import "WMTopicVoiceView.h"
#import "WMTopicPictureView.h"
#import "WMUser.h"
#import "WMComment.h"
#import <UIImageView+WebCache.h>



@interface WMTopicCell ()


@property (nonatomic, weak) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
/* 图片 */
@property (weak, nonatomic) WMTopicPictureView *pictureView;
/* 声音 */
@property (weak, nonatomic) WMTopicVoiceView *voiceView;
/* 音频 */
@property (weak, nonatomic) WMTopicVideoView *videoView;


@end

@implementation WMTopicCell


- (WMTopicVideoView *)videoView {
    
    if (!_videoView) {
        WMTopicVideoView *video = [WMTopicVideoView viewFromXib];
        [self.contentView addSubview:video];
        _videoView = video;
    }
    
    return _videoView;
}

- (WMTopicVoiceView *)voiceView  {
    if (!_voiceView) {
        WMTopicVoiceView *voice = [WMTopicVoiceView viewFromXib];
        [self.contentView addSubview:voice];
        _voiceView = voice;
    }
    return _voiceView;
}

- (WMTopicPictureView *)pictureView {
    if (!_pictureView) {
        WMTopicPictureView *picture = [WMTopicPictureView viewFromXib];
        [self.contentView addSubview:picture];
        _pictureView = picture;
    }
    return _pictureView;
}

- (IBAction)more:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[收藏]按钮");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         NSLog(@"点击了[举报]按钮");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了[取消]按钮");
    }]];
    
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}

//
//- (void)awakeFromNib {
//    
//    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
//    
//}

// 设置数据
- (void)setTopic:(WMTopic *)topic {
    
    _topic = topic;
    
    self.profileImageView.layer.cornerRadius = 10;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:self.topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLable.text = self.topic.name;
    self.text_label.text = self.topic.text;
    self.createdAtLabel.text = self.topic.created_at;
    
    [self setupButton:self.dingButton number:self.topic.ding placeholder:@"顶"];
    [self setupButton:self.caiButton number:self.topic.ding placeholder:@"踩"];
    [self setupButton:self.repostButton number:self.topic.repost placeholder:@"分享"];
    [self setupButton:self.commentButton number:self.topic.comment placeholder:@"评论"];
    
    
    // 判断有没有最热评论
//    NSDictionary *comment = topic.top_cmt.firstObject;
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        
        NSString *userName = topic.top_cmt.user.username;
        NSString *content = topic.top_cmt.content;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", userName, content];
    }else {
        self.topCmtView.hidden = YES;
    }
    
    
    // 中间内容
#pragma mark - 根据XMGTopic模型数据的情况来决定中间添加什么控件(内容)
    if (topic.type == WMTopicTypeVideo) { // 视频
        self.videoView.hidden = NO;
        self.videoView.frame = topic.contentF;
        self.videoView.topic = topic;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
        
    } else if (topic.type == WMTopicTypeVoice) { // 音频
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
        
        self.voiceView.frame = topic.contentF;
        self.voiceView.topic = topic;
        
    } else if (topic.type == WMTopicTypeWord) { // 段子
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.hidden = YES;
    } else if (topic.type == WMTopicTypePicture) { // 图片
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.hidden = NO;
        
        self.pictureView.frame = topic.contentF;
        self.pictureView.topic = topic;
    }
    
}

/**
 *  设置按钮的数字 (placeholder是一个中文参数, 故意留到最后, 前面的参数就可以使用点语法等智能提示)
 */
- (void)setupButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder {
    
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

/**
 *  重写这个方法的目的: 能够拦截所有设置cell frame的操作
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    frame.origin.y += 10;
    
    [super setFrame:frame];
}



@end
