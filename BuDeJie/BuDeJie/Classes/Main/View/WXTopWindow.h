//
//  WXTopWindow.h
//  BuDeJie
//
//  Created by liwx on 16/1/27.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXTopWindow : UIWindow

/**
 *  显示顶层window
 *
 *  @param block 这个block会在状态栏区域被点击的时候调用
 */
+ (void)showWithStatusBarClickBlock:(void (^)())block;

@end
