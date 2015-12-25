//
//  XZCalendarViewCell.m
//  CalendarDemo
//
//  Created by xianzhiliao on 15/12/21.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import "XZCalendarViewCell.h"
#import <Masonry/Masonry.h>

@implementation XZCalendarViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.dateLabel = ({
            UILabel *dateLabel = [UILabel new];
            dateLabel.textColor = [UIColor blackColor];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            dateLabel;
        });
        self.reminderLabel = ({
            UILabel *reminderLabel = [UILabel new];
            reminderLabel.textAlignment = NSTextAlignmentCenter;
            reminderLabel;
        });
        UIStackView *stackView = ({
            UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_dateLabel, _reminderLabel]];
            stackView.translatesAutoresizingMaskIntoConstraints = NO;
            stackView.axis = UILayoutConstraintAxisVertical;
            stackView.distribution = UIStackViewDistributionEqualSpacing;
            stackView.alignment = UIStackViewAlignmentFill;
            stackView.spacing = 8;
            [self.contentView addSubview:stackView];
            [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.contentView);
            }];
            stackView;
        });
        [self.contentView addSubview:stackView];
    }
    return  self;
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

@end
