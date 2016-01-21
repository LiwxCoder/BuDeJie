//
//  WXFastLoginView.m
//  BuDeJie
//
//  Created by liwx on 16/1/21.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXFastLoginView.h"

@interface WXFastLoginView ()


@end

@implementation WXFastLoginView

- (void)awakeFromNib
{

}

// ----------------------------------------------------------------------------
// 快速创建快速登录view
+ (instancetype)fastLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


@end
