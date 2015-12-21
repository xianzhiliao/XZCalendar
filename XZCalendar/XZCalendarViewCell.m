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

- (instancetype)init
{
    if (self = [super init]) {
        self.dateLabel = ({
            UILabel *dateLabel = [UILabel new];
            dateLabel.backgroundColor = [UIColor redColor];
            dateLabel;
        });
        self.reminderLabel = ({
            UILabel *reminderLabel = [UILabel new];
            reminderLabel.backgroundColor = [UIColor greenColor];
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
                make.edges.equalTo(self.contentView);
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
