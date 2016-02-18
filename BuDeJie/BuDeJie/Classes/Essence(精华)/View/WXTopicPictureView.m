//
//  WXTopicPictureView.m
//  BuDeJie
//
//  Created by liwx on 16/2/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXTopicPictureView.h"
#import "WXTopicItem.h"
#import <UIImageView+WebCache.h>

@interface WXTopicPictureView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
//@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@end

@implementation WXTopicPictureView

- (void)setTopicItem:(WXTopicItem *)topicItem
{
    _topicItem = topicItem;
    
    // 设置图片
    [self.imageView wx_setLargetImage:topicItem.image1 smallImage:topicItem.image0 placeholder:nil];
    
    // 控制gif图片隐藏/显示
    self.gifView.hidden = !topicItem.is_gif;
    
    // 显示长图按钮
    if (topicItem.isBigPicture) {
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

@end
