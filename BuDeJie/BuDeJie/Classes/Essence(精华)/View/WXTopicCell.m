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
    [self.dingButton setTitle:[NSString stringWithFormat:@"%ld", topicItem.ding] forState:UIControlStateNormal];
    [self.caiButton setTitle:[NSString stringWithFormat:@"%ld", topicItem.cai] forState:UIControlStateNormal];
    [self.repostButton setTitle:[NSString stringWithFormat:@"%ld", topicItem.repost] forState:UIControlStateNormal];
    [self.commentButton setTitle:[NSString stringWithFormat:@"%ld", topicItem.comment] forState:UIControlStateNormal];
    self.topCmtContentLabel.text = @"最热评论测试数据最热评论测试数据最热评论测试数据最热评论测试数据";
}

@end
