//
//  NSCalendar+Init.m
//  21-日期处理
//
//  Created by liwx on 16/1/30.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "NSCalendar+Init.h"

@implementation NSCalendar (Init)

// ----------------------------------------------------------------------------
// 快速创建NSCalendar,适配不同版本的iOS系统创建NSCalendar对象
+ (instancetype)wx_calendar
{
    // 判断是否有calendarWithIdentifier:方法,该方法iOS8之后才能用
    // respondsToSelector是对象方法,用NSCalendar类对象调用,敲时不会提示
    // 因为currentCalendar方法在新的iOS系统会出现问题,所以需判断如果是iOS8以上的用calendarWithIdentifier创建对象
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    
    return [NSCalendar currentCalendar];
    
}

@end
