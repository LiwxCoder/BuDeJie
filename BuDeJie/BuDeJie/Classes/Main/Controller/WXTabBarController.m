//
//  WXTabBarController.m
//  BuDeJie
//
//  Created by liwx on 16/1/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXTabBarController.h"
#import "WXEssenceViewController.h"
#import "WXNewViewController.h"
#import "WXPublishViewController.h"
#import "WXFriendTrendViewController.h"
#import "WXMeViewController.h"
#import "WXTabBar.h"
#import "WXNavigationController.h"

@interface WXTabBarController ()

@end

@implementation WXTabBarController

#pragma =======================================================================
#pragma mark - 系统方法重写
// ----------------------------------------------------------------------------
// 第一次使用当前类或者它的子类的时候调用
+ (void)initialize
{
    // 一次性设置tabBarItem字体颜色
    // 1.判断是否是WXTabBarController
    if (self == [WXTabBarController class]) {
        // 1.1 获取item
        UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
        
        NSDictionary *attrNormal = @{NSForegroundColorAttributeName : [UIColor redColor]};
        [item setTitleTextAttributes:attrNormal forState:UIControlStateSelected];
        NSDictionary *attrHigh = @{NSForegroundColorAttributeName : [UIColor grayColor]};
        [item setTitleTextAttributes:attrHigh forState:UIControlStateNormal];
    }
}

// ----------------------------------------------------------------------------
// view加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加所有子控制器
    [self setupAllChildViewController];
 
    // 2.设置所有tabBarButton
    [self setupAllTabBarButton];
    
    // 3.设置自定义tabBar
    [self setupTabBar];
}

#pragma =======================================================================
#pragma mark - 初始化设置
// ----------------------------------------------------------------------------
// 添加所有子控制器
- (void)setupAllChildViewController
{
    // 精华
    [self setupOneChildViewController:[[WXEssenceViewController alloc] init]];
    
    // 新帖
    [self setupOneChildViewController:[[WXNewViewController alloc] init]];
    
    // 发布
//    [self setupOneChildViewController:[[WXPublishViewController alloc] init]];
    
    // 关注
    [self setupOneChildViewController:[[WXFriendTrendViewController alloc] init]];
    
    // 我
    [self setupOneChildViewController:[[WXMeViewController alloc] init]];
}

// ----------------------------------------------------------------------------
// 添加一个子控制器
- (void)setupOneChildViewController:(UIViewController *)viewController
{
    // 1.包装导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
}

// ----------------------------------------------------------------------------
// 设置所有tabBarButton
- (void)setupAllTabBarButton
{
    // 精华tabBarItem设置
    [self setupOneTabBarButtonVcIndex:0 titile:@"精华" imageName:@"tabBar_essence_icon" selectedImageName:@"tabBar_essence_click_icon"];
    
    // 新帖tabBarItem设置
    [self setupOneTabBarButtonVcIndex:1 titile:@"新帖" imageName:@"tabBar_new_icon" selectedImageName:@"tabBar_new_click_icon"];
    
    // 关注tabBarItem设置
    [self setupOneTabBarButtonVcIndex:2 titile:@"关注" imageName:@"tabBar_friendTrends_icon" selectedImageName:@"tabBar_friendTrends_click_icon"];
    
    // 我tabBarItem设置
    [self setupOneTabBarButtonVcIndex:3 titile:@"我" imageName:@"tabBar_me_icon" selectedImageName:@"tabBar_me_click_icon"];
}

// ----------------------------------------------------------------------------
// 设置一个tabBarButton信息
- (void)setupOneTabBarButtonVcIndex:(NSInteger)vcIndex titile:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.获取子控制器(UINavigationController),并设置标题和图片
    WXNavigationController *nav = self.childViewControllers[vcIndex];
    
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    nav.tabBarItem.selectedImage = [UIImage imageWithOriginalRender:selectedImageName];
}

// ----------------------------------------------------------------------------
// 设置自定义tabBar
- (void)setupTabBar
{
    WXTabBar *tabBar = [[WXTabBar alloc] init];
    // 1.将系统的tabBar换成自定义tabBar,系统的tabBar是readOnly,用KVC设置
    [self setValue:tabBar forKey:@"tabBar"];
}



@end
