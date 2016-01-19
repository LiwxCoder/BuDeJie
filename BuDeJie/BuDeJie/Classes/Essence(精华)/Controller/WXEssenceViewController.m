//
//  WXEssenceViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXEssenceViewController.h"

@interface WXEssenceViewController ()

@end

@implementation WXEssenceViewController

#pragma =======================================================================
#pragma mark - 系统方法重写
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    // 设置导航条按钮
    [self setupNavigationItem];
}

#pragma =======================================================================
#pragma mark - 设置导航条按钮
// ----------------------------------------------------------------------------
// 设置导航条按钮
- (void)setupNavigationItem
{
    // 设置导航条左侧游戏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(gameBarButtonClick)];
    
    // 设置导航条右侧随机按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(randomBarButtonClick)];
}

// ----------------------------------------------------------------------------
// 监听导航条左侧游戏按钮点击
- (void)gameBarButtonClick
{
    WXFunc();
}

// ----------------------------------------------------------------------------
// 监听导航条左侧游戏按钮点击
- (void)randomBarButtonClick
{
    WXFunc();
}


@end
