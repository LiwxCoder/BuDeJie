//
//  WXRefreshFooter.m
//  s
//
//  Created by liwx on 16/1/31.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXRefreshFooter.h"

@implementation WXRefreshFooter

// ----------------------------------------------------------------------------
// 初始化设置
- (void)prepare
{
    [super prepare];
    
    // 设置状态文字颜色
    self.stateLabel.textColor = [UIColor orangeColor];
}

@end
