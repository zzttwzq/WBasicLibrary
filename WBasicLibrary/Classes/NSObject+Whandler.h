//
//  NSObject+Whandler.h
//  Pods
//
//  Created by 吴志强 on 2018/7/9.
//

#import <Foundation/Foundation.h>
#import "MicroDefinetion.h"

@interface NSObject (Whandler)


#pragma mark - 获取类操作
/**
 获取当前对象的属性名称数组

 @return NSArray 性名称数组
 */
-(NSArray *)getObjectPropName;


/**
 获取当前对象的属性名称和值

 @return NSDictionary 包含属性名称和值的字典
 */
-(NSDictionary *)getObjectPropertiesAndValues;


/**
 获取当前对象的属性名称和值（属性名称都是小写）

 @return NSDictionary 包含小写属性名称和值的字典
 */
-(NSDictionary *)getObjectPropertiesLowercaseAndValues;


/**
 获取当前对象的属性和对应的类型

 @return 返回一个包含属性名称和类型的字典
 */
-(NSDictionary *)getObjectPropertiesAndTypes;


/**
 获取类方法

 @return 类方法的名称数组
 */
+(NSArray *)getClassMethodName;

#pragma mark - 赋值类操作
/**
 给当前对象的某个属性赋值(kvc)

 @param key 属性
 @param value 值
 */
-(void)setObjWithKey:(NSString *)key value:(id)value;


/**
 使用字典包含的属性和值给对象赋值

 @param dic 包含的属性和值给对象的字典
 */
-(void)setObjWithDic:(NSDictionary *)dic;

#pragma mark - 绑定方法或属性
//@property (nonatomic,copy) NSString *linkKey;


@end
