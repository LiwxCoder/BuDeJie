//
//  WXTopicItem.h
//  BuDeJie
//
//  Created by liwx on 16/1/29.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <Foundation/Foundation.h>

// ----------------------------------------------------------------------------
// 帖子的类型
typedef NS_ENUM(NSInteger, WXTopicType) {
    /** 全部 */
    WXTopicTypeAll = 1,
    /** 图片 */
    WXTopicTypePicture = 10,
    /** 文字 */
    WXTopicTypeWord = 29,
    /** 声音 */
    WXTopicTypeVoice = 31,
    /** 视频 */
    WXTopicTypeVideo = 41
};

@interface WXTopicItem : NSObject

#pragma =======================================================================
#pragma mark - 服务器返回的模型数据

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 帖子的类型 */
@property (nonatomic, assign) WXTopicType type;
/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;
/** 图片宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片高度 */
@property (nonatomic, assign) CGFloat height;
/** 播放数量 */
@property (nonatomic, assign) NSInteger playcount;
/** 声音文件的播放时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频文件的播放时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 大图 */
@property (nonatomic, copy) NSString *image1;
/** 中图 */
@property (nonatomic, copy) NSString *image2;


#pragma =======================================================================
#pragma mark - 额外添加的模型属性(方便开发使用)

/** 通过这个模型计算出来的cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 中间内容的frame */
@property (nonatomic, assign) CGRect centerFrame;

@end
