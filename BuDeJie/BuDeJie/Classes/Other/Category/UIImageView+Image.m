//
//  UIImageView+Image.m
//  BuDeJie
//
//  Created by liwx on 16/2/19.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "UIImageView+Image.h"
#import "WXTopicItem.h"
#import <UIImageView+WebCache.h>
#import <AFNetworking.h>

@implementation UIImageView (Image)

// ----------------------------------------------------------------------------
// 通过网络状态判断要下载大图或小图,显示的占位图片
- (void)wx_setLargetImage:(NSString *)largetImageUrl smallImage:(NSString *)smallImageUrl placeholder:(UIImage *)placeholder
{
    
#if TARGET_IPHONE_SIMULATOR //模拟器
    // ------------------------------------------------------------------------
    // 1.1 模拟器不同判断网络状态,直接用大图显示
    [self sd_setImageWithURL:[NSURL URLWithString:largetImageUrl] placeholderImage:placeholder];
    
#elif TARGET_OS_IPHONE      //真机
    // ------------------------------------------------------------------------
    // 1.1 在真机环境下通过判断网络状态来确定要下载大图或中图或小图
    // 如果已经下载过大图,优先显示大图
    UIImage *largeImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:largetImageUrl];
    if (largeImage) {
        // --------------------------------------------------------------------
        // 已下载过大图,直接显示大图
        self.image = largeImage;
    } else {
        // --------------------------------------------------------------------
        // 未下载过大图,使用AFNetworking判断网络状态,用于确定要下载大图/小图
        // ???: 不用__weak 修饰mgr会出现警告,为什么???
        __weak AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        __weak typeof(self) weakSelf = self;
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
//            NSLog(@"%zd", mgr.networkReachabilityStatus);
            if (mgr.isReachableViaWiFi) {           // 如果是wifi,下载大图
                [weakSelf sd_setImageWithURL:[NSURL URLWithString:largetImageUrl]];
            } else if (mgr.isReachableViaWWAN) {    // 如果是手机自带3G/4G网络,下载小图
                [weakSelf sd_setImageWithURL:[NSURL URLWithString:smallImageUrl]];
            } else {                                // 没有网络,如果有占位图片显示占位图片,如果没有占位图片则清空图片
                // 判断是否已下载过小图
                UIImage *smallImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:smallImageUrl];
                if (smallImage) {
                    weakSelf.image = smallImage;
                } else {
                    weakSelf.image = nil;     // 根据需求显示占位图片或清空图片
                }
            }
        }];
        
        [mgr startMonitoring];
    }
#endif
    
}

/*
- (void)wx_setLargeImage:(NSString *)largeImageUrl smallImage:(NSString *)smallImageUrl placeholder:(UIImage *)placeholder
{
    [self sd_setImageWithURL:[NSURL URLWithString:largeImageUrl] placeholderImage:placeholder];
    //    // 网络状态判断只对真机有效
    //    // 优先显示曾经下载过的大图
    //    UIImage *largeImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:largeImageUrl];
    //    if (largeImage) {
    //        self.image = largeImage;
    //    } else { // 大图没有下载过
    //        AFNetworkReachabilityManager *mgr =  [AFNetworkReachabilityManager sharedManager];
    //        if (mgr.isReachableViaWiFi) { // 如果是WIFI，下载大图
    //            [self sd_setImageWithURL:[NSURL URLWithString:largeImageUrl] placeholderImage:placeholder];
    //        } else if (mgr.isReachableViaWWAN) { // 如果是手机自带网络，下载小图
    //            [self sd_setImageWithURL:[NSURL URLWithString:smallImageUrl] placeholderImage:placeholder];
    //        } else { // 没有网络
    //            UIImage *smallImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:smallImageUrl];
    //            if (smallImage) {
    //                self.image = smallImage;
    //            } else {
    //                self.image = placeholder; // 或者显示占位图片
    //            }
    //        }
    //    }
}
 */

@end
