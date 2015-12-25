//
//  ViewController.m
//  XZCalendar
//
//  Created by xianzhiliao on 15/12/18.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "XZCalendarViewCell.h"
#import "XZCalendarBrain.h"

const CGFloat Kmargin = 15;
const CGFloat KweekDayHeaderViewHeight = 31;
const CGFloat KdayMargin = 8;

@interface ViewController ()
<
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
>
// 日期大脑(进行时间比较等等)
@property (nonatomic, strong) XZCalendarBrain *calendarBrain;
// 天的大小
@property (nonatomic, assign) CGSize daySize;
// 要显示的所有月份的第一天数组
@property (nonatomic, strong) NSArray *monthFirstDateArray;
// 星期数组
@property (nonatomic, strong) NSArray *weekDayNames;
// 是否显示高亮日期
@property (nonatomic, assign) BOOL shouldShowHighLightDates;
// 最后选中的indexPath
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;


@property (nonatomic, strong) UIView *weekDayHeaderView;
@property (nonatomic, strong) UICollectionView *collectionView;



@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
#warning 配置
    self.beginDate = ({
        NSDate *date = [NSDate date];
        date;
    });
    self.showMonthCount = 6;
    self.highLightDates = @[[NSDate date]].mutableCopy;
#warning end
    self.shouldShowHighLightDates = YES;
    self.lastSelectedIndexPath =({
        [NSIndexPath indexPathForItem:-1 inSection:-1];
    });
    
    self.calendarBrain = ({
        XZCalendarBrain *calendarBrain = [XZCalendarBrain new];
        calendarBrain;
    });
    
    self.daySize = ({
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        NSInteger avgSize = (screenWidth - 2 * Kmargin - 6 * KdayMargin) / 7;
        CGSizeMake(avgSize, avgSize) ;
    });
    self.weekDayHeaderView = ({
        UIView *weekDayHeaderView = [self getWeekDayHeaderView];
        [self.view addSubview:weekDayHeaderView];
        [weekDayHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(64);
            make.height.mas_equalTo(KweekDayHeaderViewHeight);
        }];
        weekDayHeaderView;
    });
    self.collectionView = ({
        //确定是水平滚动，还是垂直滚动
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing = KdayMargin;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        //注册Cell，必须要有
        [collectionView registerClass:[XZCalendarViewCell class] forCellWithReuseIdentifier:[XZCalendarViewCell cellIdentifier]];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.opaque = NO;
        [self.view addSubview:collectionView];
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.weekDayHeaderView.mas_bottom);
        }];
        collectionView;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - Private Method

// 要展示所有月份的月份信息
- (NSArray *)monthFirstDateArray
{
    // 当前日期所在月份第一天
    if (!_monthFirstDateArray) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < self.showMonthCount; i ++) {
            NSDate *nextFirstDate = [self.calendarBrain getMonthFirstDayWithCurrentDate:self.beginDate offsetMonthLength:i];
            [self.calendarBrain getMonthInfoWithDate:nextFirstDate monthInfoBlock:^(XZCalendarViewMonthInfo *monthInfo) {
                [array addObject:monthInfo];
            }];
        }
        _monthFirstDateArray = array;
    }
    return _monthFirstDateArray;
}

- (NSArray *)weekDayNames
{
    if (!_weekDayNames) {
        _weekDayNames = @[@"日", @"一",@"二",@"三",
                          @"四", @"五", @"六"];
    }
    return _weekDayNames;
}
- (UIView *)getWeekDayHeaderView
{
    UIView *weekDayHeaderView = [UIView new];
    weekDayHeaderView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < self.weekDayNames.count; i ++) {
        UILabel *weekDay = [[UILabel alloc]initWithFrame:CGRectMake(Kmargin + i *KdayMargin + i * self.daySize.width, 0, self.daySize.width, KweekDayHeaderViewHeight)];
        weekDay.text = self.weekDayNames[i];
        if (i == 0 || i == 6) {
            weekDay.textColor = [UIColor grayColor];
        }
        else
        {
            weekDay.textColor = [UIColor blackColor];
        }
        weekDay.font = [UIFont systemFontOfSize:14];
        weekDay.backgroundColor = [UIColor redColor];
        weekDay.textAlignment = NSTextAlignmentCenter;
        [weekDayHeaderView addSubview:weekDay];
    }
    UIView *lineTop = [UIView new];
    lineTop.backgroundColor = [UIColor colorWithRed:178.0 / 225.0 green:178.0 / 225.0 blue:178.0 / 225.0 alpha:1.0];
    [weekDayHeaderView addSubview:lineTop];
    [lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weekDayHeaderView.mas_bottom);
        make.left.right.equalTo(weekDayHeaderView);
        make.height.mas_equalTo(1);
    }];
    return weekDayHeaderView;
}
// 设置cell是否高亮的样式
- (void)setCell:(XZCalendarViewCell *)cell isHighLight:(BOOL)isHighLight
{
    if (isHighLight) {
        cell.contentView.backgroundColor = [UIColor greenColor];
        cell.reminderLabel.hidden = NO;
        cell.reminderLabel.text = @"提示";
    }
    else
    {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.reminderLabel.hidden = YES;
    }
}
// 判断是否当前高亮
- (void)setCellCanBeHighLight:(XZCalendarViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if (self.highLightDates && self.highLightDates.count && self.shouldShowHighLightDates) {
        for (int i = 0; i < self.highLightDates.count; i ++) {
            NSDate *date = self.highLightDates[i];
            if ([XZCalendarBrain xzCalendar_compareDate:cell.currentDate withDate:date] == NSOrderedSame) {
                [self setCell:cell isHighLight:YES];
                //  设置当前选择
                self.lastSelectedIndexPath = indexPath;
            }
        }
    }
}
// 设置cell是否可选的样式
- (void)setCellCanBeSelected:(XZCalendarViewCell *)cell
{
    // 可选
    if ([XZCalendarBrain xzCalendar_compareDate:cell.currentDate withDate:self.beginDate] != NSOrderedAscending) {
        cell.dateLabel.textColor = [UIColor blackColor];
    }
    // 不可选
    else
    {
        cell.dateLabel.textColor = [UIColor grayColor];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    XZCalendarViewMonthInfo *monthInfo = self.monthFirstDateArray[section];
    return monthInfo.monthLength + monthInfo.monthBeginWeekDay;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier;
    identifier = [XZCalendarViewCell cellIdentifier];
    XZCalendarViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    XZCalendarViewMonthInfo *monthInfo = self.monthFirstDateArray[indexPath.section];
    if (indexPath.item >= monthInfo.monthBeginWeekDay) {
        cell.layer.cornerRadius = self.daySize.width / 2;
        cell.layer.masksToBounds = YES;
        // 是否为上次选中
        BOOL lastSelected = (indexPath == self.lastSelectedIndexPath);
        [self setCell:cell isHighLight:lastSelected];
        
        // 配置当前cell日期
        cell.currentDate = [self.calendarBrain getMonthDayWithMonthFirstDate:monthInfo.monthFirstDate offsetDayLength:(indexPath.item - monthInfo.monthBeginWeekDay)];
        
        // 设置当前设置的高亮日期
        [self setCellCanBeHighLight:cell indexPath:indexPath];
        
        // 设置是否可选的样式
        [self setCellCanBeSelected:cell];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.item + 1 - monthInfo.monthBeginWeekDay)];
    }
    else
    {
        cell.dateLabel.text = @"";
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.monthFirstDateArray.count;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.daySize;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(Kmargin, Kmargin, 0, Kmargin);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZCalendarViewMonthInfo *monthInfo = self.monthFirstDateArray[indexPath.section];
    if (indexPath.item >= monthInfo.monthBeginWeekDay)
    {
        // 设置的高亮日期不再显示
        self.shouldShowHighLightDates = NO;
        // 取消之前选中状态,设置当前为最后一次选中
        XZCalendarViewCell * cell = (XZCalendarViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (self.lastSelectedIndexPath) {
            XZCalendarViewCell *lastSelectedCell = (XZCalendarViewCell *)[collectionView cellForItemAtIndexPath:self.lastSelectedIndexPath];
            [self setCell:lastSelectedCell isHighLight:NO];
        }
        self.lastSelectedIndexPath = indexPath;
        [self setCell:cell isHighLight:YES];
        // 选中回调

    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZCalendarViewCell * cell = (XZCalendarViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    // 不可选
    if (!cell.currentDate) {
        return NO;
    }
    if ([XZCalendarBrain xzCalendar_compareDate:cell.currentDate withDate:self.beginDate] != NSOrderedAscending) {
        return YES;
    }
    // 不可选
    else
    {
        return NO;
    }
}
@end
