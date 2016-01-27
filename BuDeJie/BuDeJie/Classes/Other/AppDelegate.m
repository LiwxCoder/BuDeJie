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
        NSLog(@"--------");
    }];
    
    return YES;
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
