//
//  XZCalendarViewCell.h
//  CalendarDemo
//
//  Created by xianzhiliao on 15/12/21.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct XZCalendarViewCellStyle
{
    __unsafe_unretained UIColor *cellHighlightColor;
}XZCalendarViewCellStyle;

static inline XZCalendarViewCellStyle
XZCalendarViewCellStyleMake(UIColor *cellHighlightColor){
    XZCalendarViewCellStyle style;
    style.cellHighlightColor = cellHighlightColor;
    return style;
};

@interface XZCalendarViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *reminderLabel;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, assign) XZCalendarViewCellStyle style;
+ (NSString *)cellIdentifier;

@end
