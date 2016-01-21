//
//  WXNewViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXNewViewController.h"
#import "WXSubTagViewController.h"

@interface WXNewViewController ()

@end

@implementation WXNewViewController


#pragma =======================================================================
#pragma mark - 系统方法重写
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    // 1.设置导航条按钮
    [self setupNavigationItem];
}


#pragma =======================================================================
#pragma mark - 初始化设置
// ----------------------------------------------------------------------------
// 设置导航条按钮
- (void)setupNavigationItem
{
    // 设置导航条左侧订阅按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(subIconBarButtonClick)];
    
}

// ----------------------------------------------------------------------------
// 监听导航条左侧订阅按钮点击
- (void)subIconBarButtonClick
{
    // 跳转到推荐标签界面
    WXSubTagViewController *subTabVc = [[WXSubTagViewController alloc] init];
    
    [self.navigationController pushViewController:subTabVc animated:YES];
}

@end
