//
//  WXFriendTrendViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXFriendTrendViewController.h"

@interface WXFriendTrendViewController ()

@end

@implementation WXFriendTrendViewController

#pragma =======================================================================
#pragma mark - 系统方法重写
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    // 1.设置导航条按钮
    [self setupNavigationItem];
    // 2.设置标题
    [self setupTitle];
}

#pragma =======================================================================
#pragma mark - 初始化设置
- (void)setupTitle
{
    self.navigationItem.title = @"我的关注";
}

// ----------------------------------------------------------------------------
// 设置导航条按钮
- (void)setupNavigationItem
{
    // 设置导航条左侧订阅按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(recommentIconBarButtonClick)];
}

// ----------------------------------------------------------------------------
// 监听导航条左侧订阅按钮点击
- (void)recommentIconBarButtonClick
{
    WXFunc();
}

@end
