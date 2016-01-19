//
//  WXNavigationController.m
//  BuDeJie
//
//  Created by liwx on 16/1/19.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXNavigationController.h"

@interface WXNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation WXNavigationController

#pragma =======================================================================
#pragma mark - 设置滑动返回手势
- (void)viewDidLoad {
    [super viewDidLoad];
 
    // 恢复系统手势边缘滑动返回方式一(不可行)
    // 如果直接将系统手势清空,会有返回效果,但是在根控制器边缘滑动会导致出现假死状态,该方法不可行
//    self.interactivePopGestureRecognizer.delegate = nil;
    
    // // 恢复系统手势边缘滑动返回方式二(可行)
//    self.interactivePopGestureRecognizer.delegate = self;
    
    
    // 添加全屏滑动手势
    
    /** 
     系统手势打印结果:
     NSLog(@"%@", self.interactivePopGestureRecognizer);
     
     <UIScreenEdgePanGestureRecognizer: 0x7feab3e30c40; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7feab3c8fb10>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7feab3e306d0>)>>
     
     
     系统手势代理打印结果:
     NSLog(@"%@", self.interactivePopGestureRecognizer.delegate);
     
     <_UINavigationInteractiveTransition: 0x7feab3e306d0>
     
     打印结果分析: 系统手势代理是
     
     */
    
    // 1.获取方法的调用者
    id target = self.interactivePopGestureRecognizer.delegate;
    
    // 2.给系统的view添加手势,监听到手势调用原来系统手势代理调用的方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 2.1 设置手势代理,用于在代理方法中设置非控制器才能滑动返回
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    
    // 3.取消系统手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

// ----------------------------------------------------------------------------
// 监听系统滑动手势,如果返回YES表示允许滑动手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 设置只有在非根控制器滑动有效,因为如果根控制器滑动如果触发手势会调用pop,根控制器不能再pop,会导致假死.
    return self.childViewControllers.count > 1;
}


#pragma =======================================================================
#pragma mark - 重写系统方法
// ----------------------------------------------------------------------------
// 第一次加载到内存调用,只会调用一次,在load方法中统一设置导航条的背景图片和标题文字大小
+ (void)load
{
    // 1.获取全局的导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    // 2.设置导航条标题文字大小
    NSDictionary *titleAttr = @{NSFontAttributeName : [UIFont systemFontOfSize:20]};
    [navBar setTitleTextAttributes:titleAttr];
    
    // 3.设置导航条背景图片:一定要是UIBarMetricsDefault
    // iOS8和iOS9适配: iOS9之前:UIBarMetricsDefault,导航控制器跟控制器的view尺寸会减少64,iOS9就没有减少64了
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

#pragma =======================================================================
#pragma mark - 统一设置导航条返回按钮
// ----------------------------------------------------------------------------
// 重写pushViewController:方法,在跳转前统一设置返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // ------------------------------------------------------------------------
    // 1.判断如果不是根控制器,则设置viewController控制器返回按钮
    if (self.childViewControllers.count > 0) {
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"] target:self action:@selector(back) title:@"返回"];
    }
    
    [super pushViewController:viewController animated:animated];
}


// ----------------------------------------------------------------------------
// 点击返回调用
- (void)back
{
    [self popViewControllerAnimated:YES];
}




@end
