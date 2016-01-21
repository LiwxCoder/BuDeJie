//
//  WXSubTagItem.h
//  BuDeJie
//
//  Created by liwx on 16/1/21.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXSubTagItem : NSObject

/** 名称 */
@property (nonatomic, strong) NSString *theme_name;
/** 图片url */
@property (nonatomic, strong) NSString *image_list;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;

@end
