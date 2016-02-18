//
//  UIView+Init.m
//  BuDeJie
//
//  Created by liwx on 16/2/18.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "UIView+Init.h"

@implementation UIView (Init)

// ----------------------------------------------------------------------------
// 从xib创建view
+ (instancetype)wx_viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

@end
