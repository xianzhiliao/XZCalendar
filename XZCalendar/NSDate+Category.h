//
//  NSDate+Category.h
//  GrapeLife
//
//  Created by HuangDabiao on 15/5/14.
//  Copyright (c) 2015年 HuangDabiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
/**
 *  判断某个时间是否为明天
 */
- (BOOL)isTomorrow;
/**
 *  判断某个时间是否为后天
 */
- (BOOL)isAfterTomorrow;
/**
 *  判断某个时间是否在未来的几个月内
 */
- (BOOL)inRangeofMonth:(NSInteger)month;
/**
 *  判断某个时间是星期几，并返回星期一，星期二等
 */
+ (NSString *)getStrWeekDayWithDate:(NSDate *)date;
@end
