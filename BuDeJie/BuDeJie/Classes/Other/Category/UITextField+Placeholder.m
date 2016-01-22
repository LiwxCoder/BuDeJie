//
//  UITextField+PlaceholderColor.m
//  BuDeJie
//
//  Created by liwx on 16/1/22.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>

@implementation UITextField (PlaceholderColor)


// ----------------------------------------------------------------------------
// TODO: 方式三: 使用RunTime设置文本框的占位文字颜色
/**

### 方式三: 使用RunTime设置文本框的占位文字颜色
> 实现思路分析: 1.先保存占位文字颜色到系统类动态添加的属性. 2.取出动态添加的placeholderColor给系统的占位文字Label设置字体颜色
 

- 1.创建UITextField+Placeholder分类

- 2.使用动态添加placeholderColor属性,用于存放占位文字的颜色.
    - 在UITextField+Placeholder.h中声明`@property UIColor *placeholderColor;`,相当于是声明set,get方法.
    - 实现placeholderColor的set,get方法
    set方法中关联动态添加的属性,使用`objc_setAssociatedObject函数`关联动态添加的属性.
    使用KVC方式获取文本框的占位文字的UILabel,并给占位文字的Label设置文本颜色.
    get方法中通过`objc_getAssociatedObject函数`获取关联的对象

- 3.给系统的设置占位文字的setPlaceholder:方法添加功能
    - 自定义实现wx_setPlaceholder:方法,该方法实现给系统的setPlaceholder:方法添加设置占位文本颜色的功能
 
- 4.在load类方法将自定义的wx_setPlaceholder:方法和系统的setPlaceholder:方法交换

 */


#pragma =======================================================================
#pragma mark - RunTime实现交换方法

// ----------------------------------------------------------------------------
// 在load类方法中(类加载进内存的时候调用,只调用一次)
+ (void)load
{
    // 1.获取要交互的方法 Method是C语言结构体,不需要加*
    Method m1 = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method m2 = class_getInstanceMethod(self, @selector(wx_setPlaceholder:));
    
    // 2.交换方法
    method_exchangeImplementations(m1, m2);
}

// ----------------------------------------------------------------------------
// 给系统的方法添加设置占位文本颜色的功能
- (void)wx_setPlaceholder:(NSString *)placeholder
{
    // 1.调用交互方法,实际是调用setPlaceholderColor:方法
    [self wx_setPlaceholder:placeholder];
    
    // 2.设置保存的占位文字颜色
    self.placeholderColor = self.placeholderColor;
}


#pragma =======================================================================
#pragma mark - 使用RunTime实现关联动态添加的属性placeholderColor
// ----------------------------------------------------------------------------
// 重写set方法设置占位文本颜色
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 1.关联动态placeholderColor添加的属性,保存占位文字颜色到系统类动态添加的placeholderColor属性
    
    // object:保存到哪个对象中
    // key:属性名
    // value:属性值
    // policy:策略
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 2.使用KVC获取占位文字的Label,并设置占位文字Label的字体颜色
    UILabel *placeholderLabel = [self valueForKeyPath:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

// ----------------------------------------------------------------------------
// 重写get方法获取placeholderColor关联的对象
- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}


@end
