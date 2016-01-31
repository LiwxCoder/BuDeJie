//
//  UIImageView+Header.m
//  BuDeJie
//
//  Created by liwx on 16/1/31.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "UIImageView+Header.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Circle.h"

@implementation UIImageView (Header)

// ----------------------------------------------------------------------------
// 设置头像
- (void)wx_setHeader:(NSString *)url
{
    // 1.创建占位图片
    UIImage *placeholderImage = [UIImage wx_circleImageName:@"defaultUserIcon"];
    
    // 2.加载图片
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        // 2.1 如果图片获取失败,直接退出,否则会出现图片加载失败,占位图片不显示
        if (image == nil) return;
        // 2.2 图片加载成功,显示图片
        self.image = [image wx_circleImage];
    }];
}

@end
