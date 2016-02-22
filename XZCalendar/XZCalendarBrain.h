//
//  XZCalendarBrain.h
//  CalendarDemo
//
//  Created by xianzhiliao on 15/12/21.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZCalendarViewMonthInfo : NSObject

@property (nonatomic, strong) NSDate *monthFirstDate;
@property (nonatomic, assign) NSInteger monthBeginWeekDay;
@property (nonatomic, assign) NSInteger monthLength;
@property (nonatomic, assign) NSInteger monthRemainDays;
@property (nonatomic, assign) NSInteger monthCalendarViewRows;
- (instancetype)initWithFirstDay:(NSDate *)firstDate beginWeekDay:(NSInteger)monthBeginWeekDay length:(NSInteger)monthLength remainDays:(NSInteger)monthRemainDays calendarViewRows:(NSInteger)monthCalendarViewRows;

@end

@interface XZCalendarBrain : NSObject

/** 获得在XZCalendarBrain中的日期 */
+ (NSDate *)xzCalendar_DatewithDate:(NSDate *)date;
/** 用XZCalendarBrain中的NSCalendar进行日期比较 */
+ (NSComparisonResult)xzCalendar_compareDate:(NSDate *)date withDate:(NSDate *)otherDate;
/** 获得中国农历日期和节假日 */
+ (NSString *)chineseCalenderStringWithDate:(NSDate *)date;

/** 获得当前日期所在月份的基本信息 */
- (void)getMonthInfoWithDate:(NSDate *)date monthInfoBlock:(void(^)(XZCalendarViewMonthInfo *monthInfo))block;
/** 获得当前日期下/上某几个月的第一天 */
- (NSDate *)getMonthFirstDayWithCurrentDate:(NSDate *)date offsetMonthLength:(NSInteger)offsetMonthLength;
/** 获得当前月份第一天偏移的天数(必须是正数) */
- (NSDate *)getMonthDayWithMonthFirstDate:(NSDate *)date offsetDayLength:(NSInteger)offsetDayLength;

@end

