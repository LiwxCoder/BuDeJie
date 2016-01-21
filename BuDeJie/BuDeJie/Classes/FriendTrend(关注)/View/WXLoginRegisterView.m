//
//  WXLoginRegisterView.m
//  BuDeJie
//
//  Created by liwx on 16/1/22.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXLoginRegisterView.h"

@interface WXLoginRegisterView ()


@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation WXLoginRegisterView

- (void)awakeFromNib
{
    // 1.获取当前按钮的背景图片
    UIImage *image = self.loginButton.currentBackgroundImage;
    // 2.重新生成可拉伸图片
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    // 3.重新设置新生成的图片为按钮背景图片
    [self.loginButton setBackgroundImage:image forState:UIControlStateNormal];
}

// ----------------------------------------------------------------------------
// 快速创建登录view
+ (instancetype)loginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

// ----------------------------------------------------------------------------
// 快速创建注册view
+ (instancetype)registerView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

@end
