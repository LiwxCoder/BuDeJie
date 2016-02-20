//
//  WXTopicVoiceView.m
//  BuDeJie
//
//  Created by liwx on 16/2/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXTopicVoiceView.h"
#import "WXTopicItem.h"
#import "WXSeeBigPictureViewController.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@interface WXTopicVoiceView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@end

@implementation WXTopicVoiceView

// ----------------------------------------------------------------------------
// 重写awakeFromNib方法给imageView添加手势
- (void)awakeFromNib
{
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture)]];
}

// ----------------------------------------------------------------------------
// modal形式跳转到查看大图控制器
- (void)seeBigPicture
{
    // 1.创建控制器,传递模型数据
    WXSeeBigPictureViewController *seeBigVc = [[WXSeeBigPictureViewController alloc] init];
    seeBigVc.topicItem = self.topicItem;
    
    // 2.使用窗口的根控制器执行modal查看大图控制器
    // 2.1 只有控制器才能执行modal,而当前是在view中,获取不到控制器,可以使用窗口的根控制器来执行modal操作
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc presentViewController:seeBigVc animated:YES completion:nil];
}


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
