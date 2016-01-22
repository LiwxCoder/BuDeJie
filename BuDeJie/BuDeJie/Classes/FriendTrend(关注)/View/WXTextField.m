//
//  WXTextField.m
//  BuDeJie
//
//  Created by liwx on 16/1/22.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXTextField.h"

@implementation WXTextField

// ----------------------------------------------------------------------------
// 在awakeFromNib方法中设置文本框光标颜色和占位文字字体颜色
- (void)awakeFromNib
{
    // 1.设置光标颜色
    self.tintColor = [UIColor whiteColor];
    
    // 2.添加监听文本框开始编辑和结束编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    // 3.设置默认占位文字颜色为灰色
    // 方式一
//    [self setAttrPlaceholderColor:[UIColor lightGrayColor]];
    // 方式二
//    [self setKVCPlaceholderColor:[UIColor lightGrayColor]];
    
    // 方式三 使用RunTime设置文本框的占位文字颜色
    self.placeholderColor = [UIColor lightGrayColor];
    
}

#pragma =======================================================================
#pragma mark - 设置UITextField属性方法实现

// ----------------------------------------------------------------------------
// TODO: 设置文本框的占位文字颜色 方法一: 通过修改UITextField的attributedPlaceholder属性
// 在自定义TextField类中使用UITextField的attributedPlaceholder属性修改
- (void)setAttrPlaceholderColor:(UIColor *)placeholderColor
{
    // 1.设置富文本属性
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = placeholderColor;
    
    // 2.创建富文本属性,并设置颜色
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrDict];
    
    // 3.将富文本赋值给UITextField的attributedPlaceholder属性
    self.attributedPlaceholder = attributedString;
}


// ----------------------------------------------------------------------------
// TODO: 设置文本框的占位文字颜色 方法二: 使用KVC方式设置
// 该方法有前提,必须在设置占位文字颜色前先设置占位文字,因为占位文本Label是使用懒加载,如果使用KVC方式获取占位文本Label时,有可能该Label还没创建,所以使用该方法必须确保占位文本Label已经创建.
- (void)setKVCPlaceholderColor:(UIColor *)placeholderColor
{
    // 1.使用KVC获取文本框中的占位文字Label
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    
    // 2.设置占位文字Label的颜色
    placeholderLabel.textColor = placeholderColor;
}

#pragma =======================================================================
#pragma mark - 监听文本框事件
// ----------------------------------------------------------------------------
// 监听到文本框开始编辑
- (void)textBegin
{
    // 方式一
//    [self setAttrPlaceholderColor:[UIColor whiteColor]];
    // 方式二
    //    [self setKVCPlaceholderColor:[UIColor whiteColor]];
    
    // 方式三 使用RunTime设置文本框的占位文字颜色
    self.placeholderColor = [UIColor whiteColor];
}

// ----------------------------------------------------------------------------
// 监听到文本框结束编辑调用
- (void)textEnd
{
    // 方式一
//    [self setAttrPlaceholderColor:[UIColor lightGrayColor]];
    // 方式二
    //    [self setKVCPlaceholderColor:[UIColor lightGrayColor]];
    
    // 方式三 使用RunTime设置文本框的占位文字颜色
    self.placeholderColor = [UIColor lightGrayColor];
}

@end
