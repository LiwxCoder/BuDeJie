//
//  WXTabBar.m
//  BuDeJie
//
//  Created by liwx on 16/1/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXTabBar.h"

@interface WXTabBar ()

/** 中间加号按钮 */
@property (nonatomic, weak) UIButton *plusButton;

@end

@implementation WXTabBar

#pragma =======================================================================
#pragma mark - 懒加载
// ----------------------------------------------------------------------------
// 加号按钮
- (UIButton *)plusButton
{
    if (_plusButton == nil) {
        UIButton *plusButton = [[UIButton alloc] init];
        [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        // 设置尺寸
        [plusButton sizeToFit];
        _plusButton = plusButton;
        
        [self addSubview:plusButton];
    }
    return _plusButton;
}

#pragma =======================================================================
#pragma mark - 布局子控件
// ----------------------------------------------------------------------------
// 重新布局tabBar子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.定义frame属性
    NSInteger count = self.items.count;
    CGFloat itemX = 0;
    CGFloat itemY = 0;
    CGFloat itemW = self.wx_width / (count + 1);
    CGFloat itemH = self.wx_height;
    
    // 2.遍历子控件(过滤UITabBarButton), UITabBarButton是私有属性
    NSInteger index = 0;
    for (UIView *view in self.subviews) {
        // 2.1 过滤UITabBarButton
        // 可以用两张方式判断
        // 1.[view isKindOfClass:NSClassFromString(@"UITabBarButton")]
        // 2.[@"UITabBarButton" isEqualToString:NSStringFromClass([view class])]
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            
            // 2.2 计算x值,并设置frame
            itemX = index * itemW;
            view.frame = CGRectMake(itemX, itemY, itemW, itemH);
            
            index++;
            // 判断如果是是第二个batBarButton,空一格
            if (index == 2) {
                index++;
            }
        }
    }
    
    // 3.设置加号按钮
    self.plusButton.center = CGPointMake(self.wx_width * 0.5, self.wx_height * 0.5);
}


@end
