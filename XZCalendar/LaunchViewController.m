//
//  LaunchViewController.m
//  XZCalendar
//
//  Created by xianzhiliao on 15/12/25.
//  Copyright © 2015年 LXZ. All rights reserved.
//

#import "LaunchViewController.h"
#import <Masonry/Masonry.h>
#import "ViewController.h"

@interface LaunchViewController ()

@property (nonatomic, strong) UILabel *lblSelectedDateDesc;
@property (nonatomic, strong) UIButton *btnGoSelectedDate;
@property (nonatomic, strong) NSDate *curentDate;

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curentDate = ({
        [NSDate date];
    });
    self.lblSelectedDateDesc = ({
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"显示日期";
        label.backgroundColor = [UIColor grayColor];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(30);
        }];
        label;
    });
    self.btnGoSelectedDate = ({
        UIButton *btn = [UIButton new];
        btn.backgroundColor = [UIColor redColor];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(gotoSelecteVC:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"选择日期" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lblSelectedDateDesc.mas_bottom).offset(20);
            make.centerX.equalTo(self.lblSelectedDateDesc);
        }];
        btn;
    });
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)gotoSelecteVC:(UIButton *)sender
{
    ViewController *vc = [ViewController new];
    vc.beginDate = [NSDate date];
    vc.showMonthCount = 6;
    vc.highLightDates = @[self.curentDate].mutableCopy;
    vc.calendarViewDateDidSelected = ^(NSDate *selectedDate)
    {
        if (selectedDate) {
            self.curentDate = selectedDate;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy年-MM月-dd日"];
            NSString *dateStr = [dateFormatter stringFromDate:selectedDate];
            self.lblSelectedDateDesc.text = dateStr;
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}


@end
