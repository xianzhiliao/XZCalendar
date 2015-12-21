//
//  XZCalendarBrain.m
//  CalendarDemo
//
//  Created by xianzhiliao on 15/12/21.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import "XZCalendarBrain.h"

@implementation XZCalendarBrain

static NSCalendar *_calendar;
static NSCalendarUnit _calendarUnit;
static NSDate *_calendarBeginDate;


- (instancetype)init
{
    return [self initWithBeginDate:[NSDate date]];
}

- (instancetype)initWithBeginDate:(NSDate *)beginDate
{
    if (self = [super init]) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _calendarUnit = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        _calendarBeginDate = beginDate;
        NSDateComponents *components = [_calendar components:_calendarUnit fromDate:_calendarBeginDate];
        [self getMonthInfoBlock:^(NSInteger monthBeginWeekDay, NSInteger monthLength, NSInteger monthRemainDays) {
            _xzCalendar_Rows = (monthLength + monthBeginWeekDay ) % 7 == 0 ? (monthLength + monthBeginWeekDay )/ 7 : ((monthLength +monthBeginWeekDay)/ 7 + 1);
        } WithDateComponents:components];
    }
    return  self;
}

- (void)getMonthInfoBlock:(void(^)(NSInteger monthBeginWeekDay, NSInteger monthLength, NSInteger monthRemainDays))block WithDateComponents:(NSDateComponents *)components
{
    components.day = 1;
    NSDate *firstDayOfMonth = [_calendar dateFromComponents:components];
    NSDateComponents *comps = [_calendar components:NSCalendarUnitWeekday fromDate:firstDayOfMonth];
    NSInteger weekdayBeginning = [comps weekday];
    weekdayBeginning -= 1;
    if(weekdayBeginning < 0)
    {
        weekdayBeginning += 7;
    }
    NSRange days = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:_calendarBeginDate];
    NSInteger monthLength = days.length;
    NSInteger remainingDays = (monthLength + weekdayBeginning) % 7;
    if (block) {
        block(weekdayBeginning,monthLength,remainingDays);
    }
}

/** 获得在XZCalendarBrain中的日期 */
+ (NSDate *)xzCalendar_DatewithDate:(NSDate *)date
{
    return nil;
}

/** 用XZCalendarBrain中的NSCalendar进行日期比较 */
+ (NSComparisonResult)xzCalendar_compareDate:(NSDate *)date withDate:(NSDate *)otherDate
{
    return nil;
}

@end
