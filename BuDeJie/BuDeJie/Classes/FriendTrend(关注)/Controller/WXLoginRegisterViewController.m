//
//  WXLoginRegisterViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/21.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXLoginRegisterViewController.h"
#import "WXFastLoginView.h"
#import "WXLoginRegisterView.h"

@interface WXLoginRegisterViewController ()
/** 底部view的占位视图 */
@property (weak, nonatomic) IBOutlet UIView *fastLoginView;
/** 中间的view */
@property (weak, nonatomic) IBOutlet UIView *middleView;
/** 中间view的距父控件左边的间距约束 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;

@end

@implementation WXLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加快速登录view
    [self setupSubViews];
}

#pragma =======================================================================
#pragma mark - 界面初始化
// ----------------------------------------------------------------------------
// 设置子控件,中间登录和注册view,底部快速登录view
- (void)setupSubViews
{
    // 1.添加中间登录view
    WXLoginRegisterView *loginView = [WXLoginRegisterView loginView];
    [self.middleView addSubview:loginView];
    
    // 2.添加中间注册view
    WXLoginRegisterView *registerView = [WXLoginRegisterView registerView];
    [self.middleView addSubview:registerView];
    
    // 3.添加底部快速登录view
    WXFastLoginView *fastLoginView = [WXFastLoginView fastLoginView];
    [self.fastLoginView addSubview:fastLoginView];
}

// ----------------------------------------------------------------------------
// 设置控制器的view的子控件的尺寸,在该方法中能获取到子控件的真实尺寸位置
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // 1.重新布局中间登录view
    WXLoginRegisterView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.wx_width * 0.5, self.middleView.wx_height);
    
    // 2.重新布局中间注册view
    WXLoginRegisterView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.wx_width * 0.5, 0, self.middleView.wx_width * 0.5, self.middleView.wx_height);
    
    // 3.重新布局底部快速登录view
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
    
    // 2.更新约束
    self.leftMargin.constant = self.leftMargin.constant == 0 ? -screenW : 0;
    
    // 3.执行动画
    [UIView animateWithDuration:0.25 animations:^{
        // 3.1 强制刷新
        [self.view layoutIfNeeded];
    }];
    
}
@end
