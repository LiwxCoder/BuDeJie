//
//  NSDate+Interval.m
//  21-日期处理
//
//  Created by liwx on 16/1/30.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "NSDate+Interval.h"
#import "NSCalendar+Init.h"

#pragma =======================================================================
#pragma mark - WXInterval自定义日期类
@implementation WXInterval

@end


#pragma =======================================================================
#pragma mark - NSDate+Interval分类
@implementation NSDate (Interval)

// ----------------------------------------------------------------------------
// 计算date到self之间走过的秒数,本方法使用自定义日期类实现, 可以使用多种方法实现: 使用数组方式,字典方式,结构体方式,
- (WXInterval *)wx_intervalSinceDate:(NSDate *)date
{
    // TODO: 计算date到self之间走过的秒数
    NSInteger interval = [self timeIntervalSinceDate:date];
    
    // 1分钟 = 60秒
    NSInteger secondsPerMinute = 60;
    NSInteger secondsPerHour = 60 * secondsPerMinute;
    NSInteger secondsPerDay = 24 * secondsPerHour;
    
    WXInterval *intervalStruct = [[WXInterval alloc] init];
    intervalStruct.day = interval / secondsPerDay;
    intervalStruct.hour = (interval % secondsPerDay) / secondsPerHour;
    intervalStruct.minute = ((interval % secondsPerDay) % secondsPerHour) / secondsPerMinute;
    intervalStruct.second = interval % secondsPerMinute;
    
    return intervalStruct;
}

// ----------------------------------------------------------------------------
// 判断是否是今天
- (BOOL)wx_isInToday
{
    // 1.创建日历类
    NSCalendar *calendar = [NSCalendar wx_calendar];
    
    // 2.获得年月日
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    NSDateComponents *dateCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 判断是否是今天方法一,并返回
//    return selfCmps.day == dateCmps.day && selfCmps.month == dateCmps.month && selfCmps.year == dateCmps.year;
    
    // 此处isEqual方法已被系统重新,比较的是内容,不是内存地址,所以用该方法也能比较日期
    return [selfCmps isEqual:dateCmps];
    
}

//// ----------------------------------------------------------------------------
//// 判断是否是今天 使用将日期转成字符串再比较
//- (BOOL)wx_isInToday2
//{
//    // 设置格式
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"yyyyMMdd";
//    
//    // 比较self和当前时间的年月日
//    NSString *selfString = [fmt stringFromDate:self];
//    NSString *dateString = [fmt stringFromDate:[NSDate date]];
//    
//    // 返回比较结果,比较两个字符串是否一样,比较字符串内容是否相等,三种方式都可以
////    return [selfString compare:dateString] == NSOrderedSame;
////    return [selfString isEqual:dateString];
//    return [selfString isEqualToString:dateString];
//}

// ----------------------------------------------------------------------------
// 判断是否是今年
- (BOOL)wx_isInThisYear
{
    // 创建日历对象
    NSCalendar *calendar = [NSCalendar wx_calendar];
    
    // 获取年,仅仅比较年是否一样
    NSCalendarUnit unit = NSCalendarUnitYear;
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    NSDateComponents *dateCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 返回比较结果
    return [selfCmps isEqual:dateCmps];
}

// ----------------------------------------------------------------------------
// 比较是否是昨天
- (BOOL)wx_isInYesterday
{
    // 判断self是否为昨天
    // self = 2016-01-29 10:18:01 -> 2016-01-29 00:00:00
    // now  = 2016-01-30 09:18:01 -> 2016-01-30 00:00:00
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    // 获得只有年月日的字符串对象
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    // 获得只有年月日的日期对象
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    // 比较是否和当前时间相差一天, 只需获取天即可,系统会自动比较年月.此处不能获取年月日,否则判断有误.
    NSCalendar *calendar = [NSCalendar wx_calendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    // 如果条件成立,说明self是昨天
    return cmps.day == 1;
}

// ----------------------------------------------------------------------------
// 判断是否是明天
- (BOOL)wx_isInTomorrow
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMdd";
    
    // 获得只有年月日的字符串对象
    NSString *selfString = [fmt stringFromDate:self];
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    
    // 获得只有年月日的日期对象
    NSDate *selfDate = [fmt dateFromString:selfString];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    // 比较是否和当前时间相差一天, 只需获取天即可,系统会自动比较年月.此处不能获取年月日,否则判断有误.
    NSCalendar *calendar = [NSCalendar wx_calendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    // 如果条件成立,说明self是昨天
    return cmps.day == -1;
}



@end
