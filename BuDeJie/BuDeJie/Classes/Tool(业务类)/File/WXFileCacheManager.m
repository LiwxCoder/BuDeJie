//
//  WXFileCacheManager.m
//  BuDeJie
//
//  Created by liwx on 16/1/23.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXFileCacheManager.h"

@implementation WXFileCacheManager


// ----------------------------------------------------------------------------
// TODO: 移除文件夹路径下的所有文件
+ (void)removeDirectoriesPath:(NSString *)directoriesPath completeBlock:(void(^)())completeBlock
{
    // ------------------------------------------------------------------------
    // 异步(子线程)移除,此操作比较耗时,所以放在子线程执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 1.创建文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        // 2.判断是否是文件夹
        BOOL isDirectory;
        BOOL isExists = [mgr fileExistsAtPath:directoriesPath isDirectory:&isDirectory];
        if (!isExists || !isDirectory) {
            NSException *exp = [NSException exceptionWithName:@"directoriesPathError" reason:@"directoriesPath must be directory" userInfo:nil];
            [exp raise];
        }
        
        // 3.获取路径下所有子路径
        NSArray *subPathArray = [mgr subpathsAtPath:directoriesPath];
        
        // 4.遍历移除文件夹下的所有文件
        for (NSString *subPath in subPathArray) {
            // 4.1 拼接全路径
            NSString *fullPath = [directoriesPath stringByAppendingPathComponent:subPath];
            
            // 4.2 移除文件
            [mgr removeItemAtPath:fullPath error:nil];
        }
        
        // 5.执行移除文件完成后要处理的操作.避免block里有执行UI操作,最好在主线程下执行
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock();
            }
        });
    });
}

// ----------------------------------------------------------------------------
// TODO: 获取文件夹大小
+ (void)getCacheSizeOfDirectoriesPath:(NSString *)directoriesPath completeBlock:(void(^)(NSInteger))completeBlock
{
    // ------------------------------------------------------------------------
    // 异步(子线程)计算文件大小,此操作比较耗时,所以放在子线程计算
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // 1.创建文件管理者
        NSFileManager *mgr = [NSFileManager defaultManager];
        
        // TODO: 2.判断是否是文件夹
        BOOL isDirectory;
        // 返回值: 路径是否存在, isDirectory: 输出是否是文件夹(目录)
        BOOL isExists = [mgr fileExistsAtPath:directoriesPath isDirectory:&isDirectory];
        // 如果路径不存在或不是文件夹, 抛出异常
        if (!isExists || !isDirectory) {
            NSException *exp = [NSException exceptionWithName:@"directoriesPathError" reason:@"directoriesPath must be directory" userInfo:nil];
            [exp raise];
        }
        
        // 3.获取文件夹下的所有文件路径
        NSArray *subPathArray = [mgr subpathsAtPath:directoriesPath];
        
        // --------------------------------------------------------------------
        // 4.遍历文件夹下的所有文件,累计文件夹下的所有文件大小
        NSInteger totalSize = 0;
        for (NSString *subPath in subPathArray) {
            
            // 4.1 拼接全路径
            NSString *fullPath = [directoriesPath stringByAppendingPathComponent:subPath];
            
            // 4.2 过滤隐藏文件和文件夹: 判断如果是隐藏文件带有DS字符串,路径不存在或不是文件夹路径,则跳过
            isExists = [mgr fileExistsAtPath:fullPath isDirectory:&isDirectory];
            if ([fullPath containsString:@"DS"] || !isExists || isDirectory) {
                continue;
            }
            
            // 4.3 获取文件属性
            NSDictionary *attr = [mgr attributesOfItemAtPath:fullPath error:nil];
            
            // 4.4 获取文件大小
            NSInteger fileSize = [attr[NSFileSize] integerValue];
            
            // 4.5 累计文件大小
            totalSize += fileSize;
            
        }
        
        // --------------------------------------------------------------------
        // 执行主线程回调,因为block有刷新UI操作,所以必须在主线程执行
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock(totalSize);
            }
        });
        
    });
}

@end
