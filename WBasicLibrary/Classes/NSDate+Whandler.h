//
//  NSDate+Whandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/9.
//

#import <Foundation/Foundation.h>
#import "MicroDefinetion.h"

//时间格式
typedef NS_ENUM(NSInteger,WSystemDateTimeFormat) {
    WSystemDateTimeFormat_Date,
    WSystemDateTimeFormat_Time,
    WSystemDateTimeFormat_Year,
    WSystemDateTimeFormat_Month,
    WSystemDateTimeFormat_Day,
    WSystemDateTimeFormat_Hour,
    WSystemDateTimeFormat_Minute,
    WSystemDateTimeFormat_Second,
    WSystemDateTimeFormat_Date_Time,
    WSystemDateTimeFormat_TimeSnap,
    WSystemDateTimeFormat_Date_Hour_Minute,
    WSystemDateTimeFormat_Week,
    WSystemDateTimeFormat_Custm,
};

@interface NSDate (Whandler)

#pragma mark - 获取时间格式
/**
 获取时间格式

 @param type 需要的时间格式(可以是枚举，也可以是自定义的字符串)
 @return 返回时间格式对象
 */
+(NSDateFormatter *)formatterWithType:(id)type;


#pragma mark - 获取时间戳
/**
 获取时间

 @return 返回当前的时间戳
 */
+ (NSInteger) getNowTimeStamp;


/**
 获取某个时间的时间戳格式 (可以是时间格式的字符串，也可以是nsdate对象)

 @param date 时间字符串 或 日期对象
 @param formatter 需要的时间格式(可以是枚举，也可以是自定义的字符串)
 @return 返回s数
 */
+ (NSInteger) getTimeStampWithDate:(id)date
                         formatter:(id)formatter;


/**
 时间戳转时间格式字符串

 @param timeStamp 时间戳
 @param formatter 需要的时间格式(可以是枚举，也可以是自定义的字符串)
 @return 返回时间字符串
 */
+ (NSString *) timeStampToString:(NSInteger)timeStamp
                       formatter:(id)formatter;


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


/**
 获取时间

 @param format 需要的时间格式(可以是枚举，也可以是自定义的字符串)
 @param convertTimeZoneToChina 是否把时间转换为中国时区
 @return 返回格式化后的时间字符串
 */
+ (NSString *) getTimeWithFormart:(id)format
           convertTimeZoneToChina:(BOOL)convertTimeZoneToChina;


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


/**
 和当前时间比较的差多少秒

 @param formatter formatter
 @param oldTime 要比较的时间
 @return 返回 现在的时间-oldtime 的秒数
 */
+(NSTimeInterval)compareNowTimeWithFormatter:(id)formatter
                                     oldTime:(NSString *)oldTime;



@end