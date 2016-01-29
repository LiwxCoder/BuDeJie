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
// 加载类进内存的时候调用,只会调用一次(子类不会加载的适合不再加载父类的load方法)
+ (void)load
{
    // 谁才能使用appearance?只要遵守了这个UIAppearance协议,就能调用appearance
    // 注意:UIAppearance并不是所有属性都能设置
    // 哪些属性可以通过UIAppearance设置?只要属性有UI_APPEARANCE_SELECTOR这个宏描述,就可以使用UIAppearance设置
    // UIAppearance使用场景
    
    // 一次性设置tabBarItem字体颜色
    // ------------------------------------------------------------------------
    // 1.判断是否是WXTabBarController类
    // 1.1 获取item
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 1.2 设置
    NSDictionary *attrSelected = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    [item setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    
    // ------------------------------------------------------------------------
    // 2.设置普通状态下的TabBar字体大小, 注意:一定要先设置正常状态下字体大小
    NSDictionary *attrNormal = @{NSFontAttributeName : [UIFont systemFontOfSize:13]};
    [item setTitleTextAttributes:attrNormal forState:UIControlStateNormal];
    
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
    
    // TabBarController默认控制器
    self.selectedIndex = WXDefaultVcIndex;
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
    // TODO: Storyboard加载控制器,storyboard必须手动加载控制器
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([WXMeViewController class]) bundle:nil];
    WXMeViewController *meVc = [storyboard instantiateInitialViewController];
    [self setupOneChildViewController:meVc];
}

// ----------------------------------------------------------------------------
// 添加一个子控制器
- (void)setupOneChildViewController:(UIViewController *)viewController
{
    // 1.包装导航控制器
    WXNavigationController *nav = [[WXNavigationController alloc] initWithRootViewController:viewController];
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
