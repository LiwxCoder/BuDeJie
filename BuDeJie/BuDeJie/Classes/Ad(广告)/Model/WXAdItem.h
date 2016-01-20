//
//  WXAdItem.h
//  BuDeJie
//
//  Created by liwx on 16/1/20.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXAdItem : NSObject

// 图片url
@property (nonatomic, strong) NSString *w_picurl;
// 点击广告跳转界面
@property (nonatomic, strong) NSString *ori_curl;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@end
