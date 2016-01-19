//
//  WXMeViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXMeViewController.h"

@interface WXMeViewController ()

@end

@implementation WXMeViewController


#pragma =======================================================================
#pragma mark - 系统方法重写
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    // 1.设置导航条按钮
    [self setupNavigationItem];
    // 2.设置标题
    [self setupTitle];
}


#pragma =======================================================================
#pragma mark - 初始化设置
- (void)setupTitle
{
    self.navigationItem.title = @"我的";
    
}

// ----------------------------------------------------------------------------
// 设置导航条按钮
- (void)setupNavigationItem
{
    // 设置导航条右侧设置按钮
    UIBarButtonItem *settingItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingBarButtonClick)];
    
    // 设置导航条右侧月亮按钮
    UIBarButtonItem *nightItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(nightBarButtonClick:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, nightItem];
}

// ----------------------------------------------------------------------------
// 监听导航条右侧设置按钮点击
- (void)settingBarButtonClick
{
    WXFunc();
}

// ----------------------------------------------------------------------------
// 监听导航条右侧月亮按钮点击
- (void)nightBarButtonClick:(UIButton *)button
{
    button.selected = !button.isSelected;
    WXFunc();
}

@end
