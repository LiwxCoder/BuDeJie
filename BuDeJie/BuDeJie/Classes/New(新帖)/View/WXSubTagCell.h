//
//  WXSubTagCell.h
//  BuDeJie
//
//  Created by liwx on 16/1/21.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXSubTagItem;

@interface WXSubTagCell : UITableViewCell

/** 推荐标签模型 */
@property (nonatomic, strong) WXSubTagItem *item;

/** 快速创建cell */
+ (instancetype)subTagCell;

@end
