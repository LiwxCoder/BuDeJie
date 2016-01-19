//
//  UIBarButtonItem+Item.m
//  BuDeJie
//
//  Created by liwx on 16/1/19.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)
// ----------------------------------------------------------------------------
// 设置UIBarButtonItem的普通/高亮状态的信息
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // ------------------------------------------------------------------------
    // 用UIView包装button,解决导航条按钮点击区域大的问题
    UIView *buttonView = [[UIView alloc] initWithFrame:button.bounds];
    [buttonView addSubview:button];
    
    return [[UIBarButtonItem alloc] initWithCustomView:buttonView];
}


// ----------------------------------------------------------------------------
// 设置UIBarButtonItem的普通/选中状态的信息 
+ (UIBarButtonItem *)createItemWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button sizeToFit];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    
    // ------------------------------------------------------------------------
    // 用UIView包装button,解决导航条按钮点击区域大的问题
    UIView *buttonView = [[UIView alloc] initWithFrame:button.bounds];
    [buttonView addSubview:button];
    
    return [[UIBarButtonItem alloc] initWithCustomView:buttonView];
}

// ----------------------------------------------------------------------------
// 创建导航条返回按钮
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:( id)target action:(SEL)action title:(NSString *)title
{
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setTitle:title forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highImage forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // ------------------------------------------------------------------------
    // 要跳转导航条按钮的位置,可以通过设置内边距属性
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

@end
