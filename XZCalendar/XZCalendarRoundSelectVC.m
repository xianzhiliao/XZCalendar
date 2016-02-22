//
//  XZCalendarRoundSelectVC.m
//  XZCalendarRoundSelectVC
//
//  Created by 廖贤志 on 15/12/26.
//  Copyright © 2015年 LXZ. All rights reserved.
//

#import "XZCalendarRoundSelectVC.h"
#import <Masonry/Masonry.h>
#import "XZCalendarViewCell.h"
#import "XZCalendarBrain.h"

static const CGFloat Kmargin = 15;
static const CGFloat KweekDayHeaderViewHeight = 31;
static const CGFloat KdayMargin = 8;

/** 选中背景 */
#define KBgColorSelected  COLOR_MAIN
/** 选中文字 */
#define KTextColorSelected [UIColor whiteColor]
/** 不可选文字*/
#define KTextColorDisabled COLOR_TEXT_SUBTITLE
/** 不可选背景*/
#define KBgColorDisabled [UIColor whiteColor]
/** 可选文字*/
#define KTextColorEnabled COLOR_TEXT_TITLE
/** 可选背景*/
#define KBgColorEnabled [UIColor whiteColor]

#define KTextColorMonthTitle COLOR_TEXT_TITLE

@interface XZCalendarRoundSelectVC ()

<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
// 日期大脑(进行时间比较等等)
@property (nonatomic, strong) XZCalendarBrain *calendarBrain;
// 天的大小
@property (nonatomic, assign) CGSize daySize;
// 要显示的所有月份的第一天数组
@property (nonatomic, strong) NSArray *monthFirstDateArray;
// 星期数组
@property (nonatomic, strong) NSArray *weekDayNames;
// 选中的出发日期的indexPath
@property (nonatomic, strong) NSIndexPath *goDateSelectedIndexPath;
// 选中的返回日期的indexPath
@property (nonatomic, strong) NSIndexPath *backDateSelectedIndexPath;
// 是否第一次选择
@property (nonatomic, assign) BOOL isNotFirstSelected;
// 当前提示文字
@property (nonatomic, copy) NSString *remindText;
@property (nonatomic, strong) UIView *weekDayHeaderView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation XZCalendarRoundSelectVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initWithNavBar];
    self.calendarBrain = ({
        XZCalendarBrain *calendarBrain = [XZCalendarBrain new];
        calendarBrain;
    });
    self.daySize = ({
        [[self class]getCalendarDaySize];
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
        flowLayout.itemSize = self.daySize;
        flowLayout.sectionInset = UIEdgeInsetsMake(Kmargin, Kmargin, Kmargin, Kmargin);
        flowLayout.headerReferenceSize = CGSizeMake(30, 30);
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        //注册Cell，必须要有
        [collectionView registerClass:[XZCalendarViewCell class] forCellWithReuseIdentifier:[XZCalendarViewCell cellIdentifier]];
        // 注册header
        [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeader];
        
        collectionView.backgroundColor = [UIColor whiteColor];
        //        collectionView.opaque = NO;
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
- (void)dealloc
{
    
}
- (void)initWithNavBar
{
//    self.viewNaviBar.bottomLine.hidden = YES;
//    [self setNaviBarTitle:@"日期选择"];
//    self.view.backgroundColor = COLOR_VIEW_BACKGROUND_GRAY;
}
- (void)backClicked:(id)sender
{
    if (self.calendarViewDateDidSelected) {
        self.calendarViewDateDidSelected(self.goDate,self.backDate);
    }
}
#pragma mark - Private Method
+ (CGSize)getCalendarDaySize
{
    CGSize size = ({
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat avgSize = (screenWidth - 2 * Kmargin - 6 * KdayMargin) / 7;
        CGSizeMake(avgSize, avgSize) ;
    });
    return size;
}

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
    weekDayHeaderView.backgroundColor = COLOR_NAVOGATION_BG;
    for (int i = 0; i < self.weekDayNames.count; i ++) {
        UILabel *weekDay = [[UILabel alloc]initWithFrame:CGRectMake(Kmargin + i *KdayMargin + i * self.daySize.width, 0, self.daySize.width, KweekDayHeaderViewHeight)];
        weekDay.text = self.weekDayNames[i];
        if (i == 0 || i == 6) {
            weekDay.textColor = COLOR_TEXT_SUBTITLE;
        }
        else
        {
            weekDay.textColor = COLOR_TEXT_TITLE;
        }
        weekDay.font = [UIFont systemFontOfSize:14];
        weekDay.backgroundColor = [UIColor clearColor];
        weekDay.textAlignment = NSTextAlignmentCenter;
        [weekDayHeaderView addSubview:weekDay];
    }
    UIView *lineTop = [UIView new];
    lineTop.backgroundColor = [UIColor colorWithRed:178.0 / 225.0 green:178.0 / 225.0 blue:178.0 / 225.0 alpha:1.0];
    [weekDayHeaderView addSubview:lineTop];
    [lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weekDayHeaderView);
        make.left.right.equalTo(weekDayHeaderView);
        make.height.mas_equalTo(LINE_HEIGHT);
    }];
    return weekDayHeaderView;
}
// 判断是否当前高亮
- (void)setCellCanBeHighLight:(XZCalendarViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    if (self.goDate) {
        NSDate *date = self.goDate;
        if ([XZCalendarBrain xzCalendar_compareDate:cell.currentDate withDate:date] == NSOrderedSame) {
            self.remindText = @"出发";
            [self setCell:cell isSelected:YES];
            //  设置当前选择
            self.goDateSelectedIndexPath = indexPath;
        }
    }
    if (self.backDate) {
        NSDate *date = self.backDate;
        if ([XZCalendarBrain xzCalendar_compareDate:cell.currentDate withDate:date] == NSOrderedSame) {
            self.remindText = @"返回";
            [self setCell:cell isSelected:YES];
            //  设置当前选择
            self.backDateSelectedIndexPath = indexPath;
        }
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
    if (indexPath.item < monthInfo.monthBeginWeekDay)
    {
        cell.hidden = YES;
    }
    else{
        cell.hidden = NO;
        // 配置当前cell日期
        cell.currentDate = [self.calendarBrain getMonthDayWithMonthFirstDate:monthInfo.monthFirstDate offsetDayLength:(indexPath.item - monthInfo.monthBeginWeekDay)];
        // 是否为选中
        BOOL goDateSelected = (indexPath == self.goDateSelectedIndexPath);
        if (goDateSelected) {
            self.remindText = @"出发";
        }
        BOOL backDateSelected = (indexPath == self.backDateSelectedIndexPath);
        if (backDateSelected) {
            self.remindText = @"返回";
        }
        // 设置显示文字
        if ([cell.currentDate isToday]) {
            cell.dateLabel.font = [UIFont systemFontOfSize:FONTSIZE_SUBTITLE];
            cell.dateLabel.text = @"今天";
        }
        else if ([cell.currentDate isTomorrow])
        {
            cell.dateLabel.font = [UIFont systemFontOfSize:FONTSIZE_SUBTITLE];
            cell.dateLabel.text = @"明天";
        }
        else if ([cell.currentDate isAfterTomorrow])
        {
            cell.dateLabel.font = [UIFont systemFontOfSize:FONTSIZE_SUBTITLE];
            cell.dateLabel.text = @"后天";
        }
        else
        {
            cell.dateLabel.font = [UIFont systemFontOfSize:FONTSIZE_TITLE];
            cell.dateLabel.text = [NSString stringWithFormat:@"%@",@(indexPath.item + 1 - monthInfo.monthBeginWeekDay)];
        }
        // 设置中国农历显示
        cell.reminderLabel.text = [XZCalendarBrain chineseCalenderStringWithDate:cell.currentDate];
        BOOL lastSelected = (goDateSelected || backDateSelected);
        [self setCell:cell isSelected:lastSelected];
        // 设置是否可选的样式
        [self setCellCanBeSelected:cell];
        // 设置当前设置的高亮日期
        [self setCellCanBeHighLight:cell indexPath:indexPath];
    }
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.monthFirstDateArray.count;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:UICollectionElementKindSectionHeader forIndexPath:indexPath];
        headerView.backgroundColor = COLOR_VIEW_BACKGROUND_GRAY;
        // 偷懒没有重新定义一个视图
        
        UIView *lineTop = [headerView viewWithTag:998];
        if (!lineTop) {
            lineTop = [UIView new];
            lineTop.backgroundColor = COLOR_LINE;
            [headerView addSubview:lineTop];
            [lineTop mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(headerView);
                make.left.right.equalTo(headerView);
                make.height.mas_equalTo(LINE_HEIGHT);
            }];
        }
        UIView *lineBottom = [headerView viewWithTag:999];
        if (!lineBottom) {
            lineBottom = [UIView new];
            lineBottom.backgroundColor = COLOR_LINE;
            [headerView addSubview:lineBottom];
            [lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(headerView);
                make.left.right.equalTo(headerView);
                make.height.mas_equalTo(LINE_HEIGHT);
            }];
        }
        
        UILabel *monthTitle = (UILabel *)[headerView viewWithTag:1000];
        if (!monthTitle) {
            monthTitle = [UILabel new];
            monthTitle.tag = 1000;
            monthTitle.textAlignment = NSTextAlignmentLeft;
            monthTitle.textColor = KTextColorMonthTitle;
            monthTitle.font = [UIFont systemFontOfSize:FONTSIZE_SUBTITLE];
            [headerView addSubview:monthTitle];
            [monthTitle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(headerView).offset(Kmargin);
                make.right.equalTo(headerView).offset(-Kmargin);
                make.centerY.equalTo(headerView);
            }];
        }
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy年MM月"];
        XZCalendarViewMonthInfo *monthInfo = self.monthFirstDateArray[indexPath.section];
        NSString *dateString = [format stringFromDate:monthInfo.monthFirstDate];
        monthTitle.text = dateString;
        reusableview = headerView;
    }
    return reusableview;
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZCalendarViewMonthInfo *monthInfo = self.monthFirstDateArray[indexPath.section];
    XZCalendarViewCell * cell = (XZCalendarViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.item < monthInfo.monthBeginWeekDay) {
        
    }
    else
    {
        // 第一次选择，重置出发日期，返回日期默认为出发日期后一天,返回日期不再高亮
        if (!self.isNotFirstSelected) {
            self.isNotFirstSelected = YES;
            self.goDate = cell.currentDate;
            self.backDate = ({
                [NSDate dateWithTimeInterval:24 * 3600 sinceDate:self.goDate];
            });
            // 重置出发日期高亮
            if (self.goDateSelectedIndexPath) {
                XZCalendarViewCell *goDateSelectedCell = (XZCalendarViewCell *)[collectionView cellForItemAtIndexPath:self.goDateSelectedIndexPath];
                [self setCell:goDateSelectedCell isSelected:NO];
            }
            self.goDateSelectedIndexPath = indexPath;
            self.remindText = @"出发";
            [self setCell:cell isSelected:YES];
            // 取消返回日期高亮
            if (self.backDateSelectedIndexPath) {
                XZCalendarViewCell *backDateSelectedCell = (XZCalendarViewCell *)[collectionView cellForItemAtIndexPath:self.backDateSelectedIndexPath];
                [self setCell:backDateSelectedCell isSelected:NO];
                self.backDateSelectedIndexPath = [NSIndexPath indexPathForItem:-1 inSection:-1];
            }
        }
        //  不再是第一次选择
        else
        {
            // 选中日期小于出发日期,重置出发日期，返回日期为出发日期后一天
            if ([XZCalendarBrain xzCalendar_compareDate:self.goDate withDate:cell.currentDate] != NSOrderedAscending) {
                self.goDate = cell.currentDate;
                self.backDate = ({
                    [NSDate dateWithTimeInterval:24 * 3600 sinceDate:self.goDate];
                });
                // 重置出发日期高亮
                if (self.goDateSelectedIndexPath) {
                    XZCalendarViewCell *goDateSelectedCell = (XZCalendarViewCell *)[collectionView cellForItemAtIndexPath:self.goDateSelectedIndexPath];
                    [self setCell:goDateSelectedCell isSelected:NO];
                }
                self.goDateSelectedIndexPath = indexPath;
                self.remindText = @"出发";
                [self setCell:cell isSelected:YES];
            }
            // 选中日期大于出发日期,返回日期为选中日期，设置高亮返回
            else if ([XZCalendarBrain xzCalendar_compareDate:self.goDate withDate:cell.currentDate] == NSOrderedAscending){
                self.backDate = cell.currentDate;
                self.backDateSelectedIndexPath = indexPath;
                self.remindText = @"返回";
                [self setCell:cell isSelected:YES];
                // 选中回调
                if (self.calendarViewDateDidSelected) {
                    self.calendarViewDateDidSelected(self.goDate,self.backDate);
                }
            }
        }
    }
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XZCalendarViewCell * cell = (XZCalendarViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    // 不可选
    if (!cell.currentDate) {
        return NO;
    }
    return [self setCellCanBeSelected:cell];
}

#pragma mark - CalendarView Delegate

// 返回这个CalendarView是否可以被选择
- (BOOL)setCellCanBeSelected:(XZCalendarViewCell *)cell
{
    NSDate *endDate = self.endDate;
    [XZCalendarBrain xzCalendar_DatewithDate:endDate];
    // 可选
    if ([XZCalendarBrain xzCalendar_compareDate:cell.currentDate withDate:self.beginDate] != NSOrderedAscending && [XZCalendarBrain xzCalendar_compareDate:endDate withDate:cell.currentDate] != NSOrderedAscending) {
        cell.dateLabel.textColor = KTextColorEnabled;
        cell.contentView.backgroundColor = KBgColorEnabled;
        return YES;
    }
    // 不可选
    else
    {
        cell.dateLabel.textColor = KTextColorDisabled;
        cell.contentView.backgroundColor = KBgColorDisabled;
        return NO;
    }
}
// 设置cell是否被选中和没有选中的样式
- (void)setCell:(XZCalendarViewCell *)cell isSelected:(BOOL)isSelected
{
    if (isSelected){
        cell.contentView.backgroundColor = KBgColorSelected;
        cell.dateLabel.textColor = KTextColorSelected;
        if (self.remindText && self.remindText.length) {
//            cell.reminderLabel.hidden = NO;
            cell.reminderLabel.text = self.remindText;
        }
        
    }
    else
    {
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.dateLabel.textColor = KTextColorEnabled;
//        if (self.remindText && self.remindText.length) {
//            cell.reminderLabel.hidden = YES;
//        }
    }
}

@end
