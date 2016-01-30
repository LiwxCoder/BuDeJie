//
//  NSDate+Interval.h
//  21-日期处理
//
//  Created by liwx on 16/1/30.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma =======================================================================
#pragma mark - WXInterval自定义日期类
@interface WXInterval : NSObject

// TODO: 从iOS6.0开始才能用; NS_AVAILABLE_IOS(6_0);
// 从iOS2开始,iOS7过期: NS_DEPRECATED_IOS(2_0, 7_0, "Use wx_day")
@property (nonatomic, assign) NSInteger wx_day NS_AVAILABLE_IOS(6_0);
/** 天 */
@property (nonatomic, assign) NSInteger day NS_DEPRECATED_IOS(2_0, 7_0, "Use wx_day");
/** 小时 */
@property (nonatomic, assign) NSInteger hour;
/** 分组 */
@property (nonatomic, assign) NSInteger minute;
/** 秒 */
@property (nonatomic, assign) NSInteger second;


@end

#pragma =======================================================================
#pragma mark - NSDate+Interval分类

@interface NSDate (Interval)

// ----------------------------------------------------------------------------
// 计算date到self之间走过的秒数,本方法使用自定义日期类实现, 可以使用多种方法实现: 使用数组方式,字典方式,结构体方式,
- (WXInterval *)wx_intervalSinceDate:(NSDate *)date;
// ----------------------------------------------------------------------------
// 判断是否是今天
- (BOOL)wx_isInToday;

// ----------------------------------------------------------------------------
// 判断是否是今天 使用将日期转成字符串再比较
//- (BOOL)wx_isInToday2;

// ----------------------------------------------------------------------------
// 判断是否是今年
- (BOOL)wx_isInThisYear;

// ----------------------------------------------------------------------------
// 比较是否是昨天
- (BOOL)wx_isInYesterday;

// ----------------------------------------------------------------------------
// 判断是否是明天
- (BOOL)wx_isInTomorrow;





@end
