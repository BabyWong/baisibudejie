//
//  WMTopicVideoView.m
//  baisibudejie
//
//  Created by hwm on 16/3/22.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMTopicVideoView.h"

@interface WMTopicVideoView ()

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation WMTopicVideoView

- (void)awakeFromNib {
    self.autoresizingMask = UIViewAutoresizingNone;
    
}

- (void)setTopic:(WMTopic *)topic {
    
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    
    // %04zd - 占据4位,空出来的位用0来填补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
    
}

- (IBAction)playButtonClick:(id)sender {
    
    WMLog(@"playButtonClick");
    
}

@end
