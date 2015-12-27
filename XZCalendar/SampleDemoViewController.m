//
//  LaunchViewController.m
//  XZCalendar
//
//  Created by xianzhiliao on 15/12/25.
//  Copyright © 2015年 LXZ. All rights reserved.
//

#import "SampleDemoViewController.h"
#import <Masonry/Masonry.h>
#import "XZCalendarSingleSelectVC.h"
#import "XZCalendarRoundSelectVC.h"

@interface SampleDemoViewController ()

@property (nonatomic, strong) UILabel *lblSingleSelectedDateDesc;
@property (nonatomic, strong) UILabel *lblRoundSelectedDateDesc;
@property (nonatomic, strong) UIButton *btnSingleSelectedDate;
@property (nonatomic, strong) UIButton *btnRoundSelectedDate;
@property (nonatomic, strong) NSDate *curentDate;

@end

@implementation SampleDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curentDate = ({
        [NSDate date];
    });
    self.lblSingleSelectedDateDesc = ({
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"单程显示日期";
        label.backgroundColor = [UIColor grayColor];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).offset(-80);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(30);
        }];
        label;
    });
    self.btnSingleSelectedDate = ({
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor redColor];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(gotoSingleSelectVC:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"单程选择日期" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lblSingleSelectedDateDesc.mas_bottom).offset(20);
            make.centerX.equalTo(self.lblSingleSelectedDateDesc);
        }];
        btn;
    });
    self.lblRoundSelectedDateDesc = ({
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"往返显示日期";
        label.backgroundColor = [UIColor grayColor];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btnSingleSelectedDate.mas_bottom).offset(20);
            make.centerX.equalTo(self.lblSingleSelectedDateDesc);
            make.width.height.equalTo(self.lblSingleSelectedDateDesc);
        }];
        label;
    });
    self.btnRoundSelectedDate = ({
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor redColor];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(gotoRoundSelectVC:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"往返选择日期" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lblRoundSelectedDateDesc.mas_bottom).offset(20);
            make.centerX.equalTo(self.lblRoundSelectedDateDesc);
        }];
        btn;
    });
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotoSingleSelectVC:(UIButton *)sender
{
    XZCalendarSingleSelectVC *vc = [XZCalendarSingleSelectVC new];
    vc.beginDate = [NSDate date];
    vc.endDate = [NSDate dateWithTimeIntervalSinceNow:24 * 3600 * 365];
    vc.showMonthCount = 13;
    vc.remindText = @"出发";
    vc.defaultSelectedDate = self.curentDate;
    vc.calendarViewDateDidSelected = ^(NSDate *selectedDate)
    {
        if (selectedDate) {
            //更新选择日期
            self.curentDate = selectedDate;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy年-MM月-dd日"];
            NSString *dateStr = [dateFormatter stringFromDate:selectedDate];
            self.lblSingleSelectedDateDesc.text = dateStr;
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoRoundSelectVC:(UIButton *)sender
{
    XZCalendarRoundSelectVC *vc = [XZCalendarRoundSelectVC new];
    vc.beginDate = [NSDate date];
    vc.endDate = [NSDate dateWithTimeIntervalSinceNow:24 * 3600 * 365];
    vc.showMonthCount = 13;
    vc.goDate = [NSDate date];
    vc.backDate = [NSDate dateWithTimeInterval:24 * 3600 sinceDate:[NSDate date]];
    vc.goDateRemindText = @"出发";
    vc.backDateRemindText = @"返回";
    vc.calendarViewDateDidSelected = ^(NSDate *goDate,NSDate *backDate)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy年-MM月-dd日"];
        NSString *goDateStr = [dateFormatter stringFromDate:goDate];
        NSString *backDateStr = [dateFormatter stringFromDate:backDate];
        self.lblRoundSelectedDateDesc.text = [NSString stringWithFormat:@"%@,%@",goDateStr,backDateStr];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:vc animated:YES];
}


@end
