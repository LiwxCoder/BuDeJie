//
//  WXTopicCell.m
//  BuDeJie
//
//  Created by liwx on 16/1/30.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXTopicCell.h"
#import "WXTopicItem.h"
#import "WXTopicPictureView.h"
#import "WXTopicVoiceView.h"
#import "WXTopicVideoView.h"
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


// ----------------------------------------------------------------------------
// 中间控件
/** 图片控件 */
@property (nonatomic, weak) WXTopicPictureView *pictureView;
/** 声音控件 */
@property (nonatomic, weak) WXTopicVoiceView *voiceView;
/** 视频控件 */
@property (nonatomic, weak) WXTopicVideoView *videoView;

@end

@implementation WXTopicCell

#pragma =======================================================================
#pragma mark - 懒加载中间图片控件
- (WXTopicPictureView *)pictureView
{
    if (!_pictureView) {
        WXTopicPictureView *pictureView = [WXTopicPictureView wx_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (WXTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        WXTopicVoiceView *voiceView = [WXTopicVoiceView wx_viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (WXTopicVideoView *)videoView
{
    if (!_videoView) {
        WXTopicVideoView *videoView = [WXTopicVideoView wx_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

#pragma =======================================================================
#pragma mark - 设置cell的子控件
// ----------------------------------------------------------------------------
// 设置cell的背景图片,需在Assets.xcassets中设置mainCellBackground图片为可拉伸图片
- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setTopicItem:(WXTopicItem *)topicItem
{
    _topicItem = topicItem;
    
    [self.profileImageView wx_setHeader:topicItem.profile_image];
    self.nameLabel.text = topicItem.name;
    self.text_label.text = topicItem.text;
    
    // ------------------------------------------------------------------------
    // 日期处理
    [self setCreatedAt];
    
    // ------------------------------------------------------------------------
    // 底部按钮文字显示处理
    [self setButton:self.dingButton number:topicItem.ding placeholder:@"顶"];
    [self setButton:self.caiButton number:topicItem.cai placeholder:@"踩"];
    [self setButton:self.repostButton number:topicItem.repost placeholder:@"分享"];
    [self setButton:self.commentButton number:topicItem.comment placeholder:@"评论"];
    
    // ------------------------------------------------------------------------
    // 设置最热评论
    [self setTopCmt];
    
    // ------------------------------------------------------------------------
    // 设置中间图片控件的隐藏/显示
    if (self.topicItem.type == WXTopicTypePicture) {        // 图片
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        
        // 设置中间图片控件数据
        self.pictureView.topicItem = topicItem;
    } else if (self.topicItem.type == WXTopicTypeVoice) {   // 声音
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        
        // 设置中间声音图片控件数据
        self.voiceView.topicItem = topicItem;
    } else if (self.topicItem.type == WXTopicTypeVideo) {   // 视频
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        
        // 设置中间视频图片控件数据
        self.videoView.topicItem = topicItem;
    } else if (self.topicItem.type == WXTopicTypeWord) {    // 文字
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
}

/**
 
 // 最热评论数据
{
    content = "\U4e94\U767e\U5e74\U524d\U4e00\U4eba\U8e0f\U5e73\U5929\U754c\Uff0c\U4eca\U5929\U5341\U4e09\U4ebf\U4eba\U5e2e\U4f60\U8e0f\U5e73\U6625\U665a\U3002";
    ctime = "2016-01-28 16:54:32";
    "data_id" = 17032894;
    id = 42164160;
    "like_count" = 678;
    precid = 0;
    precmt =     (
    );
    preuid = 0;
    status = 0;
    user =     {
        id = 16413351;
        "is_vip" = 0;
        "personal_page" = "http://user.qzone.qq.com/DFA2DC83F91D296282FD922FA4C45181";
        "profile_image" = "http://qzapp.qlogo.cn/qzapp/100336987/DFA2DC83F91D296282FD922FA4C45181/100";
        "qq_uid" = "";
        "qzone_uid" = DFA2DC83F91D296282FD922FA4C45181;
        sex = f;
        username = "\U3001Just .";
        "weibo_uid" = "";
    };
    voicetime = 0;
    voiceuri = "";
}
 */

// ----------------------------------------------------------------------------
// 设置最热评论
- (void)setTopCmt
{
    // 1.获取最热评论数据,返回数据为字典,只显示第一条,只需取出第一条即可
    NSDictionary *dict = self.topicItem.top_cmt.firstObject;
    // 2.判断是否有最热评论数据
    if (dict) {
        
        // 1.获取最热评论 用户名 + 评论内容
        NSString *username = dict[@"user"][@"username"];
        NSString *content = dict[@"content"];
        // 判断评论内容是否为空串,空串是语音评论
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
        self.topCmtView.hidden = NO;
    } else {
        self.topCmtContentLabel.text = @"";
        self.topCmtView.hidden = YES;
    }
}

// ----------------------------------------------------------------------------
// 日期处理
- (void)setCreatedAt
{
    // 1.将日期字符串转NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createdAtDate = [fmt dateFromString:self.topicItem.created_at];
    
    NSString *createdAtText = nil;
    // ------------------------------------------------------------------------
    // 2.判断是否是今年
    if (createdAtDate.wx_isInThisYear) {
        
        if (createdAtDate.wx_isInYesterday) {       // 2.1 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            createdAtText = [fmt stringFromDate:createdAtDate];
        } else if (createdAtDate.wx_isInToday) {    // 2.2 今天
            
            // 获取时分秒
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [[NSCalendar wx_calendar] components:unit fromDate:createdAtDate toDate:[NSDate date] options:0];
            
            if (cmps.hour >= 1) {           // 间隔 >= 1小时
                createdAtText = [NSString stringWithFormat:@"%ld小时前", cmps.hour];
            } else if (cmps.minute >= 1){   // 间隔 >= 1分钟
                createdAtText = [NSString stringWithFormat:@"%ld分钟前", cmps.minute];
            } else {
                createdAtText = @"刚刚";
            }
            
        } else {    // 2.3 除了昨天,今天,今年的其他天
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            createdAtText = [fmt stringFromDate:createdAtDate];
        }
    // ------------------------------------------------------------------------
    // 去年
    } else {
        createdAtText = self.topicItem.created_at;
    }
    
    self.createdAtLabel.text = createdAtText;
}

// ----------------------------------------------------------------------------
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

#pragma =======================================================================
#pragma mark - 重写系统方法
// ----------------------------------------------------------------------------
// 重写,设置每个cell之间的间隔为10
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= WXMargin;
    
    [super setFrame:frame];
}

// ----------------------------------------------------------------------------
// 布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // ------------------------------------------------------------------------
    // 布局中间图片控件
    if (self.topicItem.type == WXTopicTypePicture) {        // 图片
        self.pictureView.frame = self.topicItem.centerFrame;
    } else if (self.topicItem.type == WXTopicTypeVoice) {   // 声音
        self.voiceView.frame = self.topicItem.centerFrame;
    } else if (self.topicItem.type == WXTopicTypeVideo) {   // 视频
        self.videoView.frame = self.topicItem.centerFrame;
    }
}

@end
