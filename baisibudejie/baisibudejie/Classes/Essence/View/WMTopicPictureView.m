//
//  WMTopicPictureView.m
//  baisibudejie
//
//  Created by hwm on 16/3/22.
//  Copyright © 2016年 hwm. All rights reserved.
//

#import "WMTopicPictureView.h"
#import <DALabeledCircularProgressView.h>
#import "WMTopic.h"
#import "WMSeeBigViewController.h"

@interface WMTopicPictureView   ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation WMTopicPictureView

- (void)awakeFromNib {
    
    // 从xib中加载进来的控件的autoresizingMask默认是UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
    
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBig)]];
}

- (void)seeBig {
    WMSeeBigViewController *seeBigC = [[WMSeeBigViewController alloc] init];
    seeBigC.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seeBigC animated:YES completion:nil];
}

- (void)setTopic:(WMTopic *)topic {
    
    _topic = topic;
    
    // 由于是模拟器(直接显示大图)
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        // receivedSize : 已经接收的图片大小
        // expectedSize : 图片的总大小
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.progressView.progress = progress;
        
        self.progressView.hidden = NO;
        
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%0.1f", progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
    }];
    
    // gif
    self.gifView.hidden = !topic.is_gif;
    
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    }else {
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
    
    
}


@end
