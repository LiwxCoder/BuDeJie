//
//  WXTopicCell.h
//  BuDeJie
//
//  Created by liwx on 16/1/30.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXTopicItem;

@interface WXTopicCell : UITableViewCell
/** 模型 */
@property (nonatomic, strong) WXTopicItem *topicItem;

@end
