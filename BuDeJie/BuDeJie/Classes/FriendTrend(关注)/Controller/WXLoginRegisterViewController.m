//
//  WXLoginRegisterViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/21.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXLoginRegisterViewController.h"
#import "WXFastLoginView.h"

@interface WXLoginRegisterViewController ()
/** 底部view的占位视图 */
@property (weak, nonatomic) IBOutlet UIView *fastLoginView;

@end

@implementation WXLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加快速登录view
    [self setupFastLoginView];
}

#pragma =======================================================================
#pragma mark - 界面初始化
// ----------------------------------------------------------------------------
// 创建快速登录view
- (void)setupFastLoginView
{
    WXFastLoginView *fastLoginView = [WXFastLoginView fastLoginView];
    [self.fastLoginView addSubview:fastLoginView];
}

// ----------------------------------------------------------------------------
// 设置控制器的view的子控件的尺寸,在该方法中能获取到子控件的真实尺寸位置
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    WXFastLoginView *fastLoginView = self.fastLoginView.subviews[0];
    fastLoginView.frame = self.fastLoginView.bounds;
}

#pragma =======================================================================
#pragma mark - 监听按钮点击
// ----------------------------------------------------------------------------
// 关闭按钮点击
- (IBAction)dismissVc
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// ----------------------------------------------------------------------------
// 注册按钮点击
- (IBAction)registerOrLogin:(UIButton *)sender
{
    // 1.切换选中状态
    sender.selected = !sender.isSelected;
    
    // 2.已在storyboard更换按钮显示文字
    
    // 3.更新约束并执行动画
    
}
@end
