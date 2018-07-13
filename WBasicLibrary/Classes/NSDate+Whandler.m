//
//  NSDate+Whandler.m
//  Pods
//
//  Created by 吴志强 on 2018/7/9.
//

#import "NSDate+Whandler.h"

@implementation NSDate (Whandler)

/**
 获取时间格式

 @param type 需要的时间格式(可以是枚举，也可以是自定义的字符串)
 @return 返回时间格式对象
 */
+(NSDateFormatter *)formatterWithType:(id)type;
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];

    if ([type isKindOfClass:[NSString class]]) {
        NSString *string = type;
        if (string.length > 0) {

            [dateformatter setDateFormat:type];
        }
        else{

            return nil;
        }
    }
    else if ([type isKindOfClass:[NSDateFormatter class]]) {

        return type;
    }
    else{

        WSystemDateTimeFormat formatter = [type intValue];

        if (formatter == WSystemDateTimeFormat_Date) {

            [dateformatter setDateFormat:@"yyyy-MM-dd"];
        }else if (formatter == WSystemDateTimeFormat_Time) {

            [dateformatter setDateFormat:@"HH:mm:ss"];
        }else if (formatter == WSystemDateTimeFormat_Year) {

            [dateformatter setDateFormat:@"yyyy"];
        }else if (formatter == WSystemDateTimeFormat_Month) {

            [dateformatter setDateFormat:@"MM"];
        }else if (formatter == WSystemDateTimeFormat_Day) {

            [dateformatter setDateFormat:@"dd"];
        }else if (formatter == WSystemDateTimeFormat_Hour) {

            [dateformatter setDateFormat:@"HH"];
        }else if (formatter == WSystemDateTimeFormat_Minute) {

            [dateformatter setDateFormat:@"mm"];
        }else if (formatter == WSystemDateTimeFormat_Second) {

            [dateformatter setDateFormat:@"ss"];
        }else if (formatter == WSystemDateTimeFormat_Date_Time) {

            [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }else if (formatter == WSystemDateTimeFormat_TimeSnap) {

            [dateformatter setDateFormat:@"yyMMddHHmmss"];
        }else if (formatter == WSystemDateTimeFormat_Date_Hour_Minute) {

            [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        }else if (formatter == WSystemDateTimeFormat_Week) {

            [dateformatter setDateFormat:@"EEEE"];
        }
    }

    return dateformatter;
}


#pragma mark - 获取时间戳
/**
 获取时间

 @return 返回当前的时间戳
 */
+ (NSInteger) getNowTimeStamp;
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:0];
    NSDateFormatter *formatter = [self formatterWithType:@(WSystemDateTimeFormat_TimeSnap)];
    return [[formatter stringFromDate:date] integerValue];
}


/**
 获取某个时间的时间戳格式 (可以是时间格式的字符串，也可以是nsdate对象)

 @param date 时间字符串 或 日期对象
 @param formatter 需要的时间格式(可以是枚举，也可以是自定义的字符串)
 @return 返回s数
 */
+ (NSInteger) getTimeStampWithDate:(id)date
                         formatter:(id)formatter;
{
        //获取dateformmater
    NSDateFormatter *dateFormatter;
    if ([formatter isKindOfClass:[NSDateFormatter class]]) {

        dateFormatter = formatter;
    }
    else {

        dateFormatter = [self formatterWithType:formatter];
    }

        //获取时间
    NSDate *dataDate;
    if ([date isKindOfClass:[NSDate class]]) {
        dataDate = date;
    }
    else if ([date isKindOfClass:[NSString class]]) {

        dataDate = [dateFormatter dateFromString:date];
    }else{

        WLOG(@"< NSDate+dateHandler > 时间未定义!!!");
        return 0;
    }

    return [[[self formatterWithType:@(WSystemDateTimeFormat_TimeSnap)] stringFromDate:date] integerValue];
}


/**
 时间戳转时间格式字符串

 @param timeStamp 时间戳
 @param formatter 需要的时间格式(可以是枚举，也可以是自定义的字符串)
 @return 返回时间字符串
 */
+ (NSString *) timeStampToString:(NSInteger)timeStamp
                       formatter:(id)formatter;
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];

        //获取dateformmater
    return [[self formatterWithType:formatter] stringFromDate:date];
}


#pragma mark - 获取当前时间
/**
 获取时间

 @param delaySeconds 从现在开始的时间加上或者减去
 @param format 时间格式
 @param convertTimeZoneToChina 是否把时间转换为中国时区
 @return 返回格式化后的时间字符串
 */
+ (NSString *) getTimeWithDelay:(NSTimeInterval)delaySeconds
                         format:(id)format
         convertTimeZoneToChina:(BOOL)convertTimeZoneToChina;
{
        //获取系统的时间日期
    NSDate *nowdate=[NSDate dateWithTimeIntervalSinceNow:delaySeconds];
    NSDateFormatter *dateformatter = [self formatterWithType:format];

    if (convertTimeZoneToChina) {

        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [dateformatter setTimeZone:timeZone];
    }

    return [dateformatter stringFromDate:nowdate];
}


/**
 获取时间

 @param format 需要的时间格式(可以是枚举，也可以是自定义的字符串)
 @param convertTimeZoneToChina 是否把时间转换为中国时区
 @return 返回格式化后的时间字符串
 */
+ (NSString *) getTimeWithFormart:(id)format
           convertTimeZoneToChina:(BOOL)convertTimeZoneToChina;
{
    return [self getTimeWithDelay:0 format:format convertTimeZoneToChina:format];
}


/**
 获取某个时间+多少秒的时间

 @param date 某个时间点 可以是时间字符串 或者是nsdate对象
 @param delay 从现在开始的时间加上或者减去
 @param format 当前时间的格式
 @param toFormat 要转换的时间格式
 @param convertTimeZoneToChina 是否把时间转换为中国时区
 @return 返回格式化后的时间字符串
 */
+ (NSString *) getTimeWithDate:(id)date
                         delay:(NSTimeInterval)delay
                        format:(id)format
                      toFormat:(id)toFormat
        convertTimeZoneToChina:(BOOL)convertTimeZoneToChina;
{
        //获取时间格式
    NSDateFormatter *formatter = [self formatterWithType:format];
    toFormat = [self formatterWithType:toFormat];

        //获取 timezone 时区
    if (convertTimeZoneToChina) {

        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [formatter setTimeZone:timeZone];
    }

        //转换时间
    NSDate *nowTime;
    if ([date isKindOfClass:[NSString class]]) {

        nowTime = [formatter dateFromString:date];
    }else{

        if ([date isKindOfClass:[NSDate class]]) {

            nowTime = date;
        }
    }

        //添加时间延迟
    nowTime = [NSDate dateWithTimeInterval:delay sinceDate:nowTime];

        //返回时间
    return [toFormat stringFromDate:nowTime];
}


#pragma mark - 比较时间
/**
 比较两个时间字符串 time1-time2

 @param formatter formatter
 @param time1 时间1
 @param time2 时间2
 @return 返回 time1-time2 的秒数
 */
+(NSTimeInterval)compareTwoTimeWithFormatter:(id)formatter
                                       time1:(NSString *)time1
                                       time2:(NSString *)time2;
{
    formatter = [self formatterWithType:formatter];

    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];

    NSTimeInterval secondCount1 = [date1 timeIntervalSince1970];
    NSTimeInterval secondCount2 = [date2 timeIntervalSince1970];

    return ceil(secondCount1-secondCount2);
}


/**
 和当前时间比较的差多少秒

 @param formatter formatter
 @param oldTime 要比较的时间
 @return 返回 现在的时间-oldtime 的秒数
 */
+(NSTimeInterval)compareNowTimeWithFormatter:(id)formatter
                                     oldTime:(NSString *)oldTime;
{
    formatter = [self formatterWithType:formatter];

    NSDate *date1 = [NSDate date];
    NSDate *date2 = [formatter dateFromString:oldTime];

    NSTimeInterval secondCount1 = [date1 timeIntervalSince1970];
    NSTimeInterval secondCount2 = [date2 timeIntervalSince1970];

    return ceil(secondCount2-secondCount1);
}

@end
