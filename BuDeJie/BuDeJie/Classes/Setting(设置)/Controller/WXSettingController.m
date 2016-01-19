//
//  WXSettingController.m
//  BuDeJie
//
//  Created by liwx on 16/1/19.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXSettingController.h"

@implementation WXSettingController

#pragma =======================================================================
#pragma mark - 系统方法重写

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置右侧跳转按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:UIBarButtonItemStyleDone target:self action:@selector(jump)];
}

// ----------------------------------------------------------------------------
// 监听跳转按钮点击
- (void)jump
{
    UIViewController *vc = [[UIViewController alloc] init];
    
    // 必须设置背景色,不然会push时会出现黑色卡顿现象
    vc.view.backgroundColor = [UIColor redColor];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
