//
//  XZCalendarBrain.h
//  CalendarDemo
//
//  Created by xianzhiliao on 15/12/21.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZCalendarBrain : NSObject

@property (nonatomic, assign, readonly) NSInteger xzCalendar_Rows;

/** 获得在XZCalendarBrain中的日期 */
+ (NSDate *)xzCalendar_DatewithDate:(NSDate *)date;

/** 用XZCalendarBrain中的NSCalendar进行日期比较 */
+ (NSComparisonResult)xzCalendar_compareDate:(NSDate *)date withDate:(NSDate *)otherDate;

- (instancetype)initWithBeginDate:(NSDate *)beginDate;


@end
