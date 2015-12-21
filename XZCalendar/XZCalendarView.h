//
//  XZCalendarView.h
//  CalendarDemo
//
//  Created by xianzhiliao on 15/12/18.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XZCalendarView;
@protocol XZCalendarViewDataSource <NSObject>


@end

@protocol XZCalendarViewDelegate <NSObject>


@end

@interface XZCalendarView : UIView

@property (nonatomic, weak, nullable) id <XZCalendarViewDataSource> dataSource;
@property (nonatomic, weak, nullable) id <XZCalendarViewDelegate> delegate;

@end
