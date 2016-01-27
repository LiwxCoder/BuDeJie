//
//  WXTopWindow.m
//  BuDeJie
//
//  Created by liwx on 16/1/27.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXTopWindow.h"

// TODO: 实现监听顶部状态栏区域的点击

#pragma =======================================================================
#pragma mark - WXTopViewController类

@interface WXTopViewController : UIViewController
/** 点击顶部状态栏区域调用的block */
@property (nonatomic, copy) void(^statusBarClickBlock)();
@end


@implementation WXTopViewController

// ----------------------------------------------------------------------------
// 监听控制器view的点击
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.statusBarClickBlock) {
        self.statusBarClickBlock();
    }
    
    // 其他写法
//    !self.statusBarClickBlock ? : self.statusBarClickBlock();
}

// ----------------------------------------------------------------------------
// 设置状态栏显示状态
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

// ----------------------------------------------------------------------------
// 设置状态栏的样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end


#pragma =======================================================================
#pragma mark - WXTopWindow类

@implementation WXTopWindow

static WXTopWindow *window_;

// ----------------------------------------------------------------------------
// 监听顶部状态栏区域的点击,block会在状态栏区域被点击的时候调用
+ (void)showWithStatusBarClickBlock:(void (^)())block
{
    // 1.判断如果该window已经创建,无需再创建,因为window整个应用程序只需要一个,无需重复创建
    if (window_) {
        return;
    }
    
    // 2.添加window到状态栏区域,window默认填充整个屏幕,所以无需设置frame
    window_ = [[WXTopWindow alloc] init];
    // 3.设置window的优先级为最高,比状态栏的优先级高 UIWindowLevelAlert(高) UIWindowLevelStatusBar(中) UIWindowLevelNormal(低,默认)
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor clearColor];
    
    // 4.需先显示window再设置根控制器
    window_.hidden = NO;
    
    // 5.设置根控制器
    WXTopViewController *topVc = [[WXTopViewController alloc] init];
    topVc.view.backgroundColor = [UIColor clearColor];
    // TODO: 经验证,在此处设置自WXTopViewController的view的frame无效
    topVc.view.frame = [UIApplication sharedApplication].statusBarFrame;
    // 控制器的view默认是长度宽度都自动拉伸,此处只需拉伸宽度,不需要拉伸高度.
    topVc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    topVc.statusBarClickBlock = block;
    window_.rootViewController = topVc;
}

// ----------------------------------------------------------------------------
// 重写hitTest
/**
 *  当用户点击屏幕时，首先会调用这个方法，询问谁来处理这个点击事件
 *
 *  @return 如果返回nil，代表当前window不处理这个点击事件
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 如果触摸点的y值 > 20，当前window不处理
    if (point.y > 20) {
        return nil;
    }
    // 如果触摸点的y值 <= 20，按照默认做法处理
    return [super hitTest:point withEvent:event];
}

@end
