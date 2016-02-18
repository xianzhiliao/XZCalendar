//
//  XZCalendarBrain.m
//  CalendarDemo
//
//  Created by xianzhiliao on 15/12/21.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import "XZCalendarBrain.h"

@implementation XZCalendarViewMonthInfo

- (instancetype)initWithFirstDay:(NSDate *)firstDate beginWeekDay:(NSInteger)monthBeginWeekDay length:(NSInteger)monthLength remainDays:(NSInteger)monthRemainDays calendarViewRows:(NSInteger)monthCalendarViewRows
{
    if (self = [super init]) {
        self.monthFirstDate = firstDate;
        self.monthBeginWeekDay = monthBeginWeekDay;
        self.monthLength = monthLength;
        self.monthRemainDays = monthRemainDays;
        self.monthCalendarViewRows = monthCalendarViewRows;
    }
    return self;
}

@end

@implementation XZCalendarBrain

static NSCalendar *_calendar;
static NSCalendarUnit _calendarUnit;

- (instancetype)init
{
    if (self = [super init]) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _calendarUnit = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    }
    return  self;
}
// 获得当前日期所在月份的基本信息
- (void)getMonthInfoWithDate:(NSDate *)date monthInfoBlock:(void(^)(XZCalendarViewMonthInfo *monthInfo))block
{
    NSDate *firstDayDateOfMonth = [self getMonthFirstDayWithCurrentDate:date offsetMonthLength:0];
    NSDateComponents *comps = [_calendar components:NSCalendarUnitWeekday fromDate:firstDayDateOfMonth];
    // 当前日期所在月份第一天是周几
    NSInteger monthBeginWeekDay = [comps weekday];
    monthBeginWeekDay -= 1;
    if(monthBeginWeekDay < 0)
    {
        monthBeginWeekDay += 7;
    }
    NSRange days = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDayDateOfMonth];
    NSInteger monthLength = days.length;
    NSInteger monthRemainDays = (monthLength + monthBeginWeekDay) % 7;
    if (block) {
         NSInteger monthCalendarViewRows = (monthLength + monthBeginWeekDay ) % 7 == 0 ? (monthLength + monthBeginWeekDay )/ 7 : ((monthLength +monthBeginWeekDay)/ 7 + 1);
        XZCalendarViewMonthInfo *monthInfo = [[XZCalendarViewMonthInfo alloc]initWithFirstDay:firstDayDateOfMonth beginWeekDay:monthBeginWeekDay length:monthLength remainDays:monthRemainDays calendarViewRows:monthCalendarViewRows];
        block(monthInfo);
    }
}

/** 获得当前日期(下/上/当前月)某几个月的第一天 */
- (NSDate *)getMonthFirstDayWithCurrentDate:(NSDate *)date offsetMonthLength:(NSInteger)offsetMonthLength
{
    NSDateComponents *components = [_calendar components:_calendarUnit fromDate:date];
    components.day = 1;
    components.month += offsetMonthLength;
    NSDate *offsetMonthFirstDate =[_calendar dateFromComponents:components];
    return offsetMonthFirstDate;
}

/** 获得当前月份第一天偏移的天数 */
- (NSDate *)getMonthDayWithMonthFirstDate:(NSDate *)date offsetDayLength:(NSInteger)offsetDayLength
{
    NSDateComponents *components = [_calendar components:_calendarUnit fromDate:date];
    components.day += offsetDayLength;
    NSDate *offsetMonthDayDate = [_calendar dateFromComponents:components];
    return offsetMonthDayDate;
}

/** 获得在XZCalendarBrain中的日期 */
+ (NSDate *)xzCalendar_DatewithDate:(NSDate *)date
{
    NSDateComponents *components = [_calendar components:_calendarUnit fromDate:date];
    date = [_calendar dateFromComponents:components];
    return date;
}

/** 用XZCalendarBrain中的NSCalendar进行日期比较 */
+ (NSComparisonResult)xzCalendar_compareDate:(NSDate *)date withDate:(NSDate *)otherDate
{
    date = [[self class]xzCalendar_DatewithDate:date];
    otherDate = [[self class]xzCalendar_DatewithDate:otherDate];
    return [date compare:otherDate];
}

@end
