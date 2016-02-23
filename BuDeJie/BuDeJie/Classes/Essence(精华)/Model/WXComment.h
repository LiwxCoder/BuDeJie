//
//  WXComment.h
//  BuDeJie
//
//  Created by liwx on 16/2/23.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WXUser;

@interface WXComment : NSObject

/** 评论id */
@property (nonatomic, copy) NSString *ID;
/** 评论内容 */
@property (nonatomic, copy) NSString *content;
/** 评论的用户 */
@property (nonatomic, strong) WXUser *user;

@end
