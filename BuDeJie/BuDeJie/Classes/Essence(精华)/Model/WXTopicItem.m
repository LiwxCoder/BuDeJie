//
//  WXTopicItem.m
//  BuDeJie
//
//  Created by liwx on 16/1/29.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXTopicItem.h"

@implementation WXTopicItem

// ----------------------------------------------------------------------------
// 计算cell高度
- (CGFloat)cellHeight
{
    // 如果已经计算过cell的高度,无需再计算
    if (_cellHeight) return _cellHeight;
    
    // ------------------------------------------------------------------------
    // 1.顶部view高度55
    _cellHeight += 55;
    
    // ------------------------------------------------------------------------
    // 2.文字高度
    // 2.1 文字最大宽度 = 屏幕宽度 - 2 * 间距
    CGFloat textMaxW = screenW - 2 * WXMargin;
    _cellHeight += [self.text boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + WXMargin;
    
    // ------------------------------------------------------------------------
    // 3.中间图片控件高度,等比例填充方式显示图片
    // 3.1 判断如果不是文字段子,累加图片控件高度
    if (self.type != WXTopicTypeWord) {
        // 3.2 计算图片控件实际的frame
        // centerW / centerH = self.width / self.height;
        CGFloat centerW = textMaxW;
        CGFloat centerH = centerW * self.height / self.width;
        CGFloat centerX = WXMargin;
        CGFloat centerY = _cellHeight;
        self.centerFrame = CGRectMake(centerX, centerY, centerW, centerH);
        
        _cellHeight += centerH + WXMargin;
    }
    
    // ------------------------------------------------------------------------
    // 3.最热评论高度 = 最热评论标题高度(20) + 最热评论内容高度
    // 3.1 取出最热评论
    NSDictionary *cmt = self.top_cmt.firstObject;
    
    if (cmt) {
        // 3.2 最热评论标题高度20
        _cellHeight += 20;
        
        // 3.3 最热评论内容高度
        NSString *username = cmt[@"user"][@"username"];
        NSString *content = cmt[@"content"];
        if (content.length == 0) {
            content = @"[语音评论]";
        }
        NSString *cmtText = [NSString stringWithFormat:@"%@ : %@", username, content];
        _cellHeight += [cmtText boundingRectWithSize:CGSizeMake(textMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height + WXMargin;
    }
    
    // ------------------------------------------------------------------------
    // 4.底部工具条高度
    _cellHeight += 35 + WXMargin;
    
    return _cellHeight;
}

@end
