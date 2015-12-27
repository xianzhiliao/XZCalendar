//
//  XZCalendarRoundSelectVC.h
//  XZCalendarRoundSelectVC
//
//  Created by 廖贤志 on 15/12/26.
//  Copyright © 2015年 LXZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZCalendarRoundSelectVC : UIViewController
// 往返日期
@property (nonatomic, strong) NSDate *goDate;
@property (nonatomic, strong) NSDate *backDate;

// 开始可选的日期
@property (nonatomic, strong) NSDate *beginDate;
// 开始不可选的日期
@property (nonatomic, strong) NSDate *endDate;
// 要展示的月份数
@property (nonatomic, assign) NSInteger showMonthCount;
// 默认选择的日期
//@property (nonatomic, strong) NSDate *defaultSelectedDate;
// 出发日期提示文字
@property (nonatomic, copy) NSString *goDateRemindText;
// 返回日期提示文字
@property (nonatomic, copy) NSString *backDateRemindText;
// 日期选择回调
typedef void (^XZCalendarRoundSelected)(NSDate *goDate, NSDate *backDate);
@property (nonatomic, copy) XZCalendarRoundSelected calendarViewDateDidSelected;
+ (CGSize)getCalendarDaySize;


@end
