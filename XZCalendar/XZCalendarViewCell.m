//
//  XZCalendarViewCell.m
//  CalendarDemo
//
//  Created by xianzhiliao on 15/12/21.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import "XZCalendarViewCell.h"
#import <Masonry/Masonry.h>
#import "XZCalendarSingleSelectVC.h"

@implementation XZCalendarViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.dateLabel = ({
            UILabel *dateLabel = [UILabel new];
            dateLabel.font = [UIFont systemFontOfSize:FONTSIZE_TITLE];
            dateLabel.textAlignment = NSTextAlignmentCenter;
            dateLabel;
        });
        self.reminderLabel = ({
            UILabel *reminderLabel = [UILabel new];
            reminderLabel.font = [UIFont systemFontOfSize:FONTSIZE_TAG];
            reminderLabel.textAlignment = NSTextAlignmentCenter;
            reminderLabel;
        });
        UIStackView *stackView = ({
            UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:@[_dateLabel, _reminderLabel]];
            stackView.translatesAutoresizingMaskIntoConstraints = NO;
            stackView.axis = UILayoutConstraintAxisVertical;
            stackView.distribution = UIStackViewDistributionEqualSpacing;
            stackView.alignment = UIStackViewAlignmentCenter;
            stackView.spacing = 2;
            [self.contentView addSubview:stackView];
            [stackView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self.contentView);
            }];
            stackView;
        });
        self.contentView.layer.cornerRadius = ({
            CGSize size = [XZCalendarSingleSelectVC getCalendarDaySize];
            size.width / 2;
        });
        [self.contentView.layer masksToBounds];
        [self.contentView addSubview:stackView];
    }
    return  self;
}

+ (NSString *)cellIdentifier
{
    return NSStringFromClass([self class]);
}

@end
