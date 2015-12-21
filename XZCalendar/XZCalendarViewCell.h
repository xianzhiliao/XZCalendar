//
//  XZCalendarViewCell.h
//  CalendarDemo
//
//  Created by xianzhiliao on 15/12/21.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZCalendarViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *reminderLabel;
+ (NSString *)cellIdentifier;

@end
