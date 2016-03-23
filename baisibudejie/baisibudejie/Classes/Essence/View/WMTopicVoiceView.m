//
//  WMTopicVoiceView.m
//  baisibudejie
//
//  Created by hwm on 16/3/22.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMTopicVoiceView.h"
#import "WMSeeBigViewController.h"

@interface WMTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation WMTopicVoiceView

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
}

- (void)setTopic:(WMTopic *)topic {
    
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    NSUInteger minute = topic.voicetime / 60;
    NSUInteger second = topic.voicetime % 60;
    
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd : %02zd", minute, second];
    
}

#pragma mark -- 大图
- (void)seeBig {
    
    WMSeeBigViewController *seeBigController = [[WMSeeBigViewController alloc] init];
    
    seeBigController.topic = self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigController animated:YES completion:nil];
    
}


@end
