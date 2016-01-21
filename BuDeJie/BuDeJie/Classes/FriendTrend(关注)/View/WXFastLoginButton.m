//
//  WXFastLoginButton.m
//  BuDeJie
//
//  Created by liwx on 16/1/21.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXFastLoginButton.h"

@implementation WXFastLoginButton



#pragma =======================================================================
#pragma mark - 调整按钮的图片和标题的位置
// ----------------------------------------------------------------------------
// 重新布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // ------------------------------------------------------------------------
    // 布局子控件
    self.imageView.wx_centerX = self.wx_width * 0.5;
    self.imageView.wx_y = 0;
    
    // 重新计算文字宽度,在给titleLabel的宽度赋值
    [self.titleLabel sizeToFit];
    
    // -5: 顶部留5间距
    self.titleLabel.wx_centerX = self.wx_width * 0.5;
    self.titleLabel.wx_y = self.wx_height - self.titleLabel.wx_height - 5;
}

@end
