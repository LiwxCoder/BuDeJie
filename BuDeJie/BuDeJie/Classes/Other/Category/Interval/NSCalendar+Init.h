//
//  NSCalendar+Init.h
//  21-日期处理
//
//  Created by liwx on 16/1/30.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (Init)
// ----------------------------------------------------------------------------
// 快速创建NSCalendar,适配不同版本的iOS系统创建NSCalendar对象
+ (instancetype)wx_calendar;

@end
