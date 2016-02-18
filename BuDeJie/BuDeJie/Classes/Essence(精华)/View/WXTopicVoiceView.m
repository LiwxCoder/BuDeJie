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
    
#if TARGET_IPHONE_SIMULATOR //模拟器
    // ------------------------------------------------------------------------
    // 1.1 模拟器不同判断网络状态,直接用大图显示
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image1]];
    
#elif TARGET_OS_IPHONE      //真机
    // ------------------------------------------------------------------------
    // 1.1 在真机环境下通过判断网络状态来确定要下载大图或中图或小图
    // 如果已经下载过大图,优先显示大图
    UIImage *largeImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topicItem.image1];
    if (largeImage) {
        // --------------------------------------------------------------------
        // 已下载过大图,直接显示大图
        self.imageView.image = largeImage;
    } else {
        // --------------------------------------------------------------------
        // 未下载过大图,使用AFNetworking判断网络状态,用于确定要下载大图/小图
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
//            NSLog(@"%zd", mgr.networkReachabilityStatus);
            if (mgr.isReachableViaWiFi) {           // 如果是wifi,下载大图
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image1]];
            } else if (mgr.isReachableViaWWAN) {    // 如果是手机自带3G/4G网络,下载小图
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image0]];
            } else {                                // 没有网络,如果有占位图片显示占位图片,如果没有占位图片则清空图片
                // 判断是否已下载过小图
                UIImage *smallImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:topicItem.image0];
                if (smallImage) {
                    self.imageView.image = smallImage;
                } else {
                    self.imageView.image = nil;     // 根据需求显示占位图片或清空图片
                }
            }
        }];
        
        [mgr startMonitoring];
    }
    
#endif
    
    
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
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds];
    
}

@end
