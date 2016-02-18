//
//  WXTopicVoiceView.m
//  BuDeJie
//
//  Created by liwx on 16/2/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXTopicVoiceView.h"
#import "WXTopicItem.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface WXTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@end

@implementation WXTopicVoiceView

// ----------------------------------------------------------------------------
// 重写模型数据的set方法,设置声音view的数据
- (void)setTopicItem:(WXTopicItem *)topicItem
{
    _topicItem = topicItem;
    
    // ------------------------------------------------------------------------
    // 1.设置图片
    [self.imageView wx_setLargetImage:topicItem.image1 smallImage:topicItem.image0 placeholder:nil];
    
    // ------------------------------------------------------------------------
    // 2.设置播放数量
    if (topicItem.playcount >= 10000) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%.1f万播放",topicItem.playcount / 10000.0];
    } else {
        self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放", topicItem.playcount];
    }
    
    // ------------------------------------------------------------------------
    // 3.设置播放时长
    NSInteger minutes = topicItem.voicetime / 60;
    NSInteger seconds = topicItem.videotime % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minutes, seconds];
    
}

@end
