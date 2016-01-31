//
//  WXHTTPSessionManager.m
//  BuDeJie
//
//  Created by liwx on 16/2/1.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXHTTPSessionManager.h"

@implementation WXHTTPSessionManager

// ----------------------------------------------------------------------------
// 初始化设置会话管理者
- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
        
        // 设置请求头
        [self.requestSerializer setValue:@"iPhone 6s" forHTTPHeaderField:@"device"];
        [self.requestSerializer setValue:@"9.2" forHTTPHeaderField:@"version"];
        
    }
    return self;
}

@end
