//
//  ViewController.h
//  XZCalendar
//
//  Created by xianzhiliao on 15/12/18.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// 要开始的日期
@property (nonatomic, strong) NSDate *beginDate;
// 要展示的月份数
@property (nonatomic, assign) NSInteger showMonthCount;
// 默认选择的日期
@property (nonatomic, strong) NSMutableArray<NSDate *> *highLightDates;
// 日期选择回调
typedef void (^CalendarViewDateDidSelected)(NSDate *selectedDate);
@property (nonatomic, copy) CalendarViewDateDidSelected calendarViewDateDidSelected;

@end

