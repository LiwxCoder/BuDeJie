//
//  MJExtensionConfig.m
//  BuDeJie
//
//  Created by liwx on 16/2/23.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "WXTopicItem.h"
#import <MJExtension.h>

@implementation MJExtensionConfig

// ----------------------------------------------------------------------------
// 类加载到内存的时候自动调用,在该方法中进行模型属性名映射
+ (void)load
{
    // ------------------------------------------------------------------------
    // 重映射WXTopicItem的模型属性
    [WXTopicItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{
                 @"small_image" : @"image0",
                 @"large_image" : @"image1",
                 @"middle_image" : @"image2",
                 @"top_cmt" : @"top_cmt[0]",
//                 @"ID" : @"id"
                 };
    }];
    
//    // ------------------------------------------------------------------------
//    // mj_setupObjectClassInArray: 数组中需要转换的模型类
//    // top_cmt是字典数组,则转为WXComment模型数组
//    [WXTopicItem mj_setupObjectClassInArray:^NSDictionary *{
//        return @{@"top_cmt" : @"WXComment"};
//    }];
    
    // ------------------------------------------------------------------------
    // 统一映射所有类中id属性为ID
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{ @"ID" : @"id"};
    }];
}

@end
