//
//  WXTopicCell.m
//  BuDeJie
//
//  Created by liwx on 16/1/30.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXTopicCell.h"
#import "WXTopicItem.h"
#import <UIImageView+WebCache.h>

@interface WXTopicCell ()


@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 最热评论-整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

@end

@implementation WXTopicCell

- (void)setTopicItem:(WXTopicItem *)topicItem
{
    _topicItem = topicItem;
    
    
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topicItem.profile_image]];
    self.nameLabel.text = topicItem.name;
    self.createdAtLabel.text = topicItem.created_at;
    self.text_label.text = topicItem.text;
    // ------------------------------------------------------------------------
    // 底部按钮文字显示处理
    [self setButton:self.dingButton number:topicItem.ding placeholder:@"顶"];
    [self setButton:self.caiButton number:topicItem.cai placeholder:@"踩"];
    [self setButton:self.repostButton number:topicItem.repost placeholder:@"分享"];
    [self setButton:self.commentButton number:topicItem.comment placeholder:@"评论"];
    
    self.topCmtContentLabel.text = @"最热评论测试数据最热评论测试数据最热评论测试数据最热评论测试数据";
}

// ------------------------------------------------------------------------
// 底部按钮文字显示处理
- (void)setButton:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    NSString *title = nil;
    if (number >= 10000) {
        title = [NSString stringWithFormat:@"%.1f万", number / 10000.0];
    }else if (number > 0) {
        title = [NSString stringWithFormat:@"%ld", number];
    }else {
        title = placeholder;
    }
    
    [button setTitle:title forState:UIControlStateNormal];
}

@end
