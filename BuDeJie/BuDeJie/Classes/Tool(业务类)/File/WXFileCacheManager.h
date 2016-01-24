//
//  WXFileCacheManager.h
//  BuDeJie
//
//  Created by liwx on 16/1/23.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXFileCacheManager : NSObject

/** 获取文件夹尺寸 */
+ (void)getCacheSizeOfDirectoriesPath:(NSString *)directoriesPath completeBlock:(void(^)(NSInteger))completeBlock;

/** 移除文件夹路径下的所有文件 */
+ (void)removeDirectoriesPath:(NSString *)directoriesPath completeBlock:(void(^)())completeBlock;
@end
