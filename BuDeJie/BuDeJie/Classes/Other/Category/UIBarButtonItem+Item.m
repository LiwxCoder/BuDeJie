//
//  UIBarButtonItem+Item.m
//  BuDeJie
//
//  Created by liwx on 16/1/19.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

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

@end
