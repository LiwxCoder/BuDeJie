//
//  AppDelegate.m
//  BuDeJie
//
//  Created by liwx on 16/1/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "AppDelegate.h"
#import "WXAdViewController.h"
#import "WXTopWindow.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1.创建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 2.设置window的根控制器
    self.window.rootViewController = [[WXAdViewController alloc] init];
    // init -> initWithNibName -> 1.判断有没有指定NibName 2.判断有没有跟控制器同名的xib,就会去加载 3.判断下有没有不带controller的xib 4.创建一个clearColor透明的View
    
    // 3.让window成为主窗口,并显示
    [self.window makeKeyAndVisible];
    
    // 4.添加topWindow
    [WXTopWindow showWithStatusBarClickBlock:^{
        [self searchAllScrollViewsInView:application.keyWindow];
    }];
    
    return YES;
}

// ----------------------------------------------------------------------------
// 查找出view里面的所有scrollView
- (void)searchAllScrollViewsInView:(UIView *)view
{
    // 1.判断是否在keyWindow的范围内(不跟window重叠),如果不在,直接退出
    if (![view wx_intersectWithView:nil]) {
        return;
    }
    
    // 2.遍历view的所有子控件和子控件的子控件,此处for循环会退出,所以递归调用会退出
    for (UIView *subview in view.subviews) {
        [self searchAllScrollViewsInView:subview];
    }
    
    // 3.判断如果scrollView,直接返回
    if (![view isKindOfClass:[UIScrollView class]]) {
        return;
    }
    
    // 4.滚动scrollView到最顶部
    UIScrollView *scrllView = (UIScrollView *)view;
    CGPoint offset = scrllView.contentOffset;
    offset.y = -scrllView.contentInset.top;
    [scrllView setContentOffset:offset animated:YES];
    
    // 滚动scrollView到最顶部
//    [scrollView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
