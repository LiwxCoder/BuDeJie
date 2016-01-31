//
//  WXRefreshHeader.m
//  BuDeJie
//
//  Created by liwx on 16/1/31.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXRefreshHeader.h"

@interface WXRefreshHeader ()

/** 显示logo图片 */
@property (nonatomic, weak) UIImageView *loginImageView;

@end

@implementation WXRefreshHeader

// ----------------------------------------------------------------------------
// 初始化子控件
- (void)prepare
{
    [super prepare];
    
    // ------------------------------------------------------------------------
    // 1.设置刷新控件属性
    // 1.1 设置自动改变透明度
    self.automaticallyChangeAlpha = YES;
    // 1.2 设置隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 1.3 设置状态文字颜色
    self.stateLabel.textColor = [UIColor orangeColor];
    
    // ------------------------------------------------------------------------
    // 2.设置刷新状态文字
    [self setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开🐴上刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在玩命刷新中..." forState:MJRefreshStateRefreshing];
    
    // ------------------------------------------------------------------------
    // 添加loginImageView
    UIImageView *loginImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    [self addSubview:loginImageView];
    self.loginImageView = loginImageView;
}

// ----------------------------------------------------------------------------
// 布局子控件
- (void)placeSubviews
{
    [super placeSubviews];
    
    // ------------------------------------------------------------------------
    // 布局loginImageView
    self.loginImageView.wx_centerX = self.wx_width * 0.5;
    self.loginImageView.wx_centerY = - self.loginImageView.wx_height;
    
}

@end
