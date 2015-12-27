//
//  XZCalendarSingleSelectVC.h
//  XZCalendarSingleSelectVC
//
//  Created by 廖贤志 on 15/12/26.
//  Copyright © 2015年 LXZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZCalendarSingleSelectVC : UIViewController

// 开始可选的日期
@property (nonatomic, strong) NSDate *beginDate;
// 开始不可选的日期
@property (nonatomic, strong) NSDate *endDate;
// 要展示的月份数
@property (nonatomic, assign) NSInteger showMonthCount;
// 默认选择的日期
@property (nonatomic, strong) NSDate *defaultSelectedDate;
@property (nonatomic, copy) NSString *remindText;
// 日期选择回调
typedef void (^XZCalendarSingleSelected)(NSDate *selectedDate);
@property (nonatomic, copy) XZCalendarSingleSelected calendarViewDateDidSelected;
+ (CGSize)getCalendarDaySize;

@end
