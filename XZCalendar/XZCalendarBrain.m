//
//  XZCalendarBrain.m
//  CalendarDemo
//
//  Created by xianzhiliao on 15/12/21.
//  Copyright © 2015年 Putao. All rights reserved.
//

#import "XZCalendarBrain.h"

@implementation XZCalendarViewMonthInfo

- (instancetype)initWithFirstDay:(NSDate *)firstDate beginWeekDay:(NSInteger)monthBeginWeekDay length:(NSInteger)monthLength remainDays:(NSInteger)monthRemainDays calendarViewRows:(NSInteger)monthCalendarViewRows
{
    if (self = [super init]) {
        self.monthFirstDate = firstDate;
        self.monthBeginWeekDay = monthBeginWeekDay;
        self.monthLength = monthLength;
        self.monthRemainDays = monthRemainDays;
        self.monthCalendarViewRows = monthCalendarViewRows;
    }
    return self;
}

@end

@implementation XZCalendarBrain

static NSCalendar *_calendar;
static NSCalendarUnit _calendarUnit;

- (instancetype)init
{
    if (self = [super init]) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _calendarUnit = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    }
    return  self;
}
// 获得当前日期所在月份的基本信息
- (void)getMonthInfoWithDate:(NSDate *)date monthInfoBlock:(void(^)(XZCalendarViewMonthInfo *monthInfo))block
{
    NSDate *firstDayDateOfMonth = [self getMonthFirstDayWithCurrentDate:date offsetMonthLength:0];
    NSDateComponents *comps = [_calendar components:NSCalendarUnitWeekday fromDate:firstDayDateOfMonth];
    // 当前日期所在月份第一天是周几
    NSInteger monthBeginWeekDay = [comps weekday];
    monthBeginWeekDay -= 1;
    if(monthBeginWeekDay < 0)
    {
        monthBeginWeekDay += 7;
    }
    NSRange days = [_calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstDayDateOfMonth];
    NSInteger monthLength = days.length;
    NSInteger monthRemainDays = (monthLength + monthBeginWeekDay) % 7;
    if (block) {
         NSInteger monthCalendarViewRows = (monthLength + monthBeginWeekDay ) % 7 == 0 ? (monthLength + monthBeginWeekDay )/ 7 : ((monthLength +monthBeginWeekDay)/ 7 + 1);
        XZCalendarViewMonthInfo *monthInfo = [[XZCalendarViewMonthInfo alloc]initWithFirstDay:firstDayDateOfMonth beginWeekDay:monthBeginWeekDay length:monthLength remainDays:monthRemainDays calendarViewRows:monthCalendarViewRows];
        block(monthInfo);
    }
}

/** 获得当前日期(下/上/当前月)某几个月的第一天 */
- (NSDate *)getMonthFirstDayWithCurrentDate:(NSDate *)date offsetMonthLength:(NSInteger)offsetMonthLength
{
    NSDateComponents *components = [_calendar components:_calendarUnit fromDate:date];
    components.day = 1;
    components.month += offsetMonthLength;
    NSDate *offsetMonthFirstDate =[_calendar dateFromComponents:components];
    return offsetMonthFirstDate;
}

/** 获得当前月份第一天偏移的天数 */
- (NSDate *)getMonthDayWithMonthFirstDate:(NSDate *)date offsetDayLength:(NSInteger)offsetDayLength
{
    NSDateComponents *components = [_calendar components:_calendarUnit fromDate:date];
    components.day += offsetDayLength;
    NSDate *offsetMonthDayDate = [_calendar dateFromComponents:components];
    return offsetMonthDayDate;
}

/** 获得在XZCalendarBrain中的日期 */
+ (NSDate *)xzCalendar_DatewithDate:(NSDate *)date
{
    NSDateComponents *components = [_calendar components:_calendarUnit fromDate:date];
    date = [_calendar dateFromComponents:components];
    return date;
}

/** 用XZCalendarBrain中的NSCalendar进行日期比较 */
+ (NSComparisonResult)xzCalendar_compareDate:(NSDate *)date withDate:(NSDate *)otherDate
{
    date = [[self class]xzCalendar_DatewithDate:date];
    otherDate = [[self class]xzCalendar_DatewithDate:otherDate];
    return [date compare:otherDate];
}

/** 获得中国农历日期和节假日 */
+ (NSString *)chineseCalenderStringWithDate:(NSDate *)date
{
    NSDateComponents *components = [_calendar components:_calendarUnit fromDate:date];
    NSString *chineseCalenderString;
    // 公历节日
    chineseCalenderString = [[self class]solarStringWithGregorianDateComponent:components];
    if (chineseCalenderString) {
        return chineseCalenderString;
    }
    NSString *lunarString = [[self class]lunarStringWithGregorianDateComponent:components];
    // 没有公历节日则显示农历或农历节日
    chineseCalenderString = [[self class]chineseHolidayForString:lunarString];
    return chineseCalenderString;
}
/**
 * @brief 根据公历年月日返回中国公历节日
 */
+ (NSString *)solarStringWithGregorianDateComponent:(NSDateComponents *)gregorianDateComponent
{
    NSInteger month = gregorianDateComponent.month;
    NSInteger day = gregorianDateComponent.day;
    NSString *solarString;
    if (month == 1 &&
        day == 1){
        solarString = @"元旦";
        
        //2.14情人节
    }else if (month == 2 &&
              day == 14){
        solarString = @"情人节";
        
        //3.8妇女节
    }else if (month == 3 &&
              day == 8){
        solarString = @"妇女节";
        
        //5.1劳动节
    }else if (month == 5 &&
              day == 1){
        solarString = @"劳动节";
        
        //6.1儿童节
    }else if (month == 6 &&
              day == 1){
        solarString = @"儿童节";
        
        //8.1建军节
    }else if (month == 8 &&
              day == 1){
        solarString = @"建军节";
        
        //9.10教师节
    }else if (month == 9 &&
              day == 10){
        solarString = @"教师节";
        
        //10.1国庆节
    }else if (month == 10 &&
              day == 1){
        solarString = @"国庆节";
        
        //11.1植树节
    }else if (month == 11 &&
              day == 1){
        solarString = @"植树节";
        
        //11.11光棍节
    }else if (month == 11 &&
              day == 11){
        solarString = @"光棍节";
        
    }else{
        
        
        //            这里写其它的节日
        
    }
    return solarString;
}
/**
 * @brief 根据公历年月日返回农历字符串 eg:二-廿五
 */
+ (NSString *)lunarStringWithGregorianDateComponent:(NSDateComponents *)gregorianDateComponent
{
    NSInteger wCurYear = gregorianDateComponent.year;
    NSInteger wCurMonth = gregorianDateComponent.month;
    NSInteger wCurDay = gregorianDateComponent.day;
    //农历日期名
    NSArray *cDayName =  [NSArray arrayWithObjects:@"*",@"初一",@"初二",@"初三",@"初四",@"初五",@"初六",@"初七",@"初八",@"初九",@"初十",
                          @"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十",
                          @"廿一",@"廿二",@"廿三",@"廿四",@"廿五",@"廿六",@"廿七",@"廿八",@"廿九",@"三十",nil];
    
    //农历月份名
    NSArray *cMonName =  [NSArray arrayWithObjects:@"*",@"正",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"腊",nil];
    
    //公历每月前面的天数
    const int wMonthAdd[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
    
    //农历数据
    const int wNongliData[100] = {2635,333387,1701,1748,267701,694,2391,133423,1175,396438
        ,3402,3749,331177,1453,694,201326,2350,465197,3221,3402
        ,400202,2901,1386,267611,605,2349,137515,2709,464533,1738
        ,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762
        ,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413
        ,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395
        ,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031
        ,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222
        ,268949,3402,3493,133973,1386,464219,605,2349,334123,2709
        ,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877};
    
    static int nTheDate,nIsEnd,m,k,n,i,nBit;
    
    
    //计算到初始时间1921年2月8日的天数：1921-2-8(正月初一)
    nTheDate = (wCurYear - 1921) * 365 + (wCurYear - 1921) / 4 + wCurDay + wMonthAdd[wCurMonth - 1] - 38;
    
    if((!(wCurYear % 4)) && (wCurMonth > 2))
        nTheDate = nTheDate + 1;
    
    //计算农历天干、地支、月、日
    nIsEnd = 0;
    m = 0;
    while(nIsEnd != 1)
    {
        if(wNongliData[m] < 4095)
            k = 11;
        else
            k = 12;
        n = k;
        while(n>=0)
        {
            //获取wNongliData(m)的第n个二进制位的值
            nBit = wNongliData[m];
            for(i=1;i<n+1;i++)
                nBit = nBit/2;
            
            nBit = nBit % 2;
            
            if (nTheDate <= (29 + nBit))
            {
                nIsEnd = 1;
                break;
            }
            
            nTheDate = nTheDate - 29 - nBit;
            n = n - 1;
        }
        if(nIsEnd)
            break;
        m = m + 1;
    }
    wCurYear = 1921 + m;
    wCurMonth = k - n + 1;
    wCurDay = nTheDate;
    if (k == 12)
    {
        if (wCurMonth == wNongliData[m] / 65536 + 1)
            wCurMonth = 1 - wCurMonth;
        else if (wCurMonth > wNongliData[m] / 65536 + 1)
            wCurMonth = wCurMonth - 1;
    }
    
    //生成农历月
    NSString *szNongliMonth;
    if (wCurMonth < 1){
        szNongliMonth = [NSString stringWithFormat:@"闰%@",(NSString *)[cMonName objectAtIndex:-1 * wCurMonth]];
    }else{
        szNongliMonth = (NSString *)[cMonName objectAtIndex:wCurMonth];
    }
    
    //生成农历日
    NSString *szNongliDay = [cDayName objectAtIndex:wCurDay];
    
    //合并
    NSString *lunarDate = [NSString stringWithFormat:@"%@-%@",szNongliMonth,szNongliDay];
    
    return lunarDate;
}

+ (NSString *)chineseHolidayForString:(NSString *)lunarFormatString
{
    NSString *chineseHoliday;
    NSArray *solarYear_arr = [lunarFormatString componentsSeparatedByString:@"-"];
    if ([solarYear_arr[1]isEqualToString:@"初一"]) {
        chineseHoliday = [NSString stringWithFormat:@"%@月",solarYear_arr[0]];
    }
    else
    {
        chineseHoliday = solarYear_arr[1];
    }
    if([solarYear_arr[0]isEqualToString:@"正"] &&
       [solarYear_arr[1]isEqualToString:@"初一"]){
        
        //正月初一：春节
        chineseHoliday = @"春节";
        
    }else if([solarYear_arr[0]isEqualToString:@"正"] &&
             [solarYear_arr[1]isEqualToString:@"十五"]){
        
        
        //正月十五：元宵节
        chineseHoliday = @"元宵";
        
    }else if([solarYear_arr[0]isEqualToString:@"二"] &&
             [solarYear_arr[1]isEqualToString:@"初二"]){
        
        //二月初二：春龙节(龙抬头)
        //        chineseHoliday = @"龙抬头";
        
    }else if([solarYear_arr[0]isEqualToString:@"五"] &&
             [solarYear_arr[1]isEqualToString:@"初五"]){
        
        //五月初五：端午节
        chineseHoliday = @"端午";
        
    }else if([solarYear_arr[0]isEqualToString:@"七"] &&
             [solarYear_arr[1]isEqualToString:@"初七"]){
        
        //七月初七：七夕情人节
        chineseHoliday = @"七夕";
        
    }else if([solarYear_arr[0]isEqualToString:@"八"] &&
             [solarYear_arr[1]isEqualToString:@"十五"]){
        
        //八月十五：中秋节
        chineseHoliday = @"中秋";
        
    }else if([solarYear_arr[0]isEqualToString:@"九"] &&
             [solarYear_arr[1]isEqualToString:@"初九"]){
        
        //九月初九：重阳节、中国老年节（义务助老活动日）
        chineseHoliday = @"重阳";
        
    }else if([solarYear_arr[0]isEqualToString:@"腊"] &&
             [solarYear_arr[1]isEqualToString:@"初八"]){
        
        //腊月初八：腊八节
        chineseHoliday = @"腊八";
        
    }else if([solarYear_arr[0]isEqualToString:@"腊"] &&
             [solarYear_arr[1]isEqualToString:@"二十四"]){
        
        
        //腊月二十四 小年
        chineseHoliday = @"小年";
        
    }else if([solarYear_arr[0]isEqualToString:@"腊"] &&
             [solarYear_arr[1]isEqualToString:@"三十"]){
        
        //腊月三十（小月二十九）：除夕
        chineseHoliday = @"除夕";
        
    }
    return chineseHoliday;
}
@end
