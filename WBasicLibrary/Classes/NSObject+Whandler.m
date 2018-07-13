//
//  NSObject+Whandler.m
//  Pods
//
//  Created by 吴志强 on 2018/7/9.
//

#import "NSObject+Whandler.h"
#import <objc/runtime.h>

@implementation NSObject (Whandler)
/**
 获取当前对象的属性名称数组

 @return NSArray 性名称数组
 */
-(NSArray *)getObjectPropName;
{
        //属性名称数组
    NSMutableArray *props = [NSMutableArray array];

        //属性列表变量
    unsigned int outCount,i;
        //获取属性列表对象
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    for (i = 0; i<outCount; i++) {

        objc_property_t property = properties[i];

        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];

        [props addObject:propertyName];
    }

    free(properties);

    return props;
}


/**
 获取当前对象的属性名称和值

 @return NSDictionary 包含属性名称和值的字典
 */
-(NSDictionary *)getObjectPropertiesAndValues;
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount,i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    for (i = 0; i<outCount; i++) {

        objc_property_t property = properties[i];

        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];

        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {

            [props setObject:propertyValue forKey:propertyName];
        }
    }

    free(properties);
    return props;
}


/**
 获取当前对象的属性名称和值（属性名称都是小写）

 @return NSDictionary 包含小写属性名称和值的字典
 */
-(NSDictionary *)getObjectPropertiesLowercaseAndValues;
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount,i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    for (i = 0; i<outCount; i++) {

        objc_property_t property = properties[i];

        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];

        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) {

            [props setObject:propertyValue forKey:[propertyName lowercaseString]];
        }
    }

    free(properties);
    return props;
}


/**
 获取当前对象的属性和对应的类型

 @return 返回一个包含属性名称和类型的字典
 */
-(NSDictionary *)getObjectPropertiesAndTypes;
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    u_int count;
    objc_property_t * properties  = class_copyPropertyList([self class], &count);
    for (int i=0; i<count; i++) {

        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];

        const char* char_f2 = property_getAttributes(property);
        NSString *propertyType = [NSString stringWithUTF8String:char_f2];

        [dic setObject:propertyType forKey:propertyName];
    }
    free(properties);

    return dic;
}


/**
 获取类方法

 @return 类方法的名称数组
 */
+(NSArray *)getClassMethodName;
{
    NSMutableArray *array = [NSMutableArray array];

    unsigned int outCount = 0;
    Method *methods = class_copyMethodList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {

        SEL sel = method_getName(methods[i]);

        NSString *string = [NSString stringWithFormat:@"%s",sel_getName(sel)];

        [array addObject:string];
    }
    free(methods);

    return array;
}


#pragma mark - 赋值类操作
/**
 给当前对象的某个属性赋值(kvc)

 @param key 属性
 @param value 值
 */
-(void)setObjWithKey:(NSString *)key value:(id)value;
{
    NSArray *propArray = [self getObjectPropName];
    if ([propArray containsObject:key]) {

        [self setValue:value forKey:key];
    }
    else{

        WLOG(@"runtimeAssosiate>>错误，没有这个key:%@",key);
    }
}


/**
 使用字典包含的属性和值给对象赋值

 @param dic 包含的属性和值给对象的字典
 */
-(void)setObjWithDic:(NSDictionary *)dic;
{
    NSArray *propArray = [self getObjectPropName];

    if ([dic isKindOfClass:[NSDictionary class]]) {

        for (NSString *key in dic) {

            if ([propArray containsObject:key]) {

                if (dic[key] &&
                    ![dic[key] isKindOfClass:[NSNull class]]) {

                    if ([dic[key] isKindOfClass:[NSString class]]) {

                        if (![dic[key] isEqualToString:@"<null>"]) {

                            [self setValue:dic[key] forKey:key];
                        }
                        else{

                            [self setValue:nil forKey:key];
                        }
                    }
                    else{

                        [self setValue:dic[key] forKey:key];
                    }
                }
            }
            else{

                WLOG(@"<Runtime> >>错误，没有这个key:%@",key);
            }
        }
    }
}


/**
 用字典设置对象的数据

 @param dict 要设置的字典
 */
-(void)setObjectValueWithDict:(NSDictionary *)dict;
{
    NSArray *propArray = [self getObjectPropName];

        //避免报错
    if ([dict isKindOfClass:[NSDictionary class]]) {

        for (NSString *key in dict) {

            if ([propArray containsObject:key]) {

                NSString *valueClassString = [NSString stringWithFormat:@"%@",[dict[key] class]];
                if ([valueClassString containsString:@"__NSCFNumber"]) {

                    [self setValue:dict[key] forKey:key];
                }
                else if ([valueClassString containsString:@"__NSCFString"]||
                         [valueClassString containsString:@"NSTaggedPointerString"]) {

                    [self setValue:dict[key] forKey:key];
                }
                else if ([valueClassString containsString:@"__NSCFBoolean"]) {

                    [self setValue:dict[key] forKey:key];
                }
            }
            else{

                WLOG(@"%@",[NSString stringWithFormat:@"runtimeAssosiate>>错误，没有这个key:%@",key]);
            }
        }
    }else{

        WLOG(@"请传入字典！");
    }
}


#pragma mark - 绑定方法或属性
-(void)setLinkKey:(NSString *)linkKey
{
    objc_setAssociatedObject(self, [linkKey UTF8String], @"adfsa", OBJC_ASSOCIATION_COPY_NONATOMIC);
}


    //- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
    //{
    //    @synchronized([self class])
    //    {
    //    //look up method signature
    //    NSMethodSignature *signature = [self methodSignatureForSelector:selector];
    //    if (!signature)
    //        {
    //            //not supported by NSNull, search other classes
    //        static NSMutableSet *classList = nil;
    //        static NSMutableDictionary *signatureCache = nil;
    //        if (signatureCache == nil)
    //            {
    //            classList = [[NSMutableSet alloc] init];
    //            signatureCache = [[NSMutableDictionary alloc] init];
    //
    //                //get class list
    //            int numClasses = objc_getClassList(NULL, 0);
    //            Class *classes = (Class *)malloc(sizeof(Class) * (unsigned long)numClasses);
    //            numClasses = objc_getClassList(classes, numClasses);
    //
    //                //add to list for checking
    //            NSMutableSet *excluded = [NSMutableSet set];
    //            for (int i = 0; i < numClasses; i++)
    //                {
    //                    //determine if class has a superclass
    //                Class someClass = classes[i];
    //                Class superclass = class_getSuperclass(someClass);
    //                while (superclass)
    //                    {
    //                    if (superclass == [NSObject class])
    //                        {
    //                        [classList addObject:someClass];
    //                        break;
    //                        }
    //                    [excluded addObject:NSStringFromClass(superclass)];
    //                    superclass = class_getSuperclass(superclass);
    //                    }
    //                }
    //
    //                //remove all classes that have subclasses
    //            for (Class someClass in excluded)
    //                {
    //                [classList removeObject:someClass];
    //                }
    //
    //                //free class list
    //            free(classes);
    //            }
    //
    //            //check implementation cache first
    //        NSString *selectorString = NSStringFromSelector(selector);
    //        signature = signatureCache[selectorString];
    //        if (!signature)
    //            {
    //                //find implementation
    //            for (Class someClass in classList)
    //                {
    //                if ([someClass instancesRespondToSelector:selector])
    //                    {
    //                    signature = [someClass instanceMethodSignatureForSelector:selector];
    //                    break;
    //                    }
    //                }
    //
    //                //cache for next time
    //            signatureCache[selectorString] = signature ?: [NSNull null];
    //            }
    //        else if ([signature isKindOfClass:[NSNull class]])
    //            {
    //            signature = nil;
    //            }
    //        }
    //    return signature;
    //    }
    //}
    //
    //- (void)forwardInvocation:(NSInvocation *)invocation
    //{
    //    invocation.target = nil;
    //    [invocation invoke];
    //}


    //+(BOOL)resolveClassMethod:(SEL)sel
    //{
    //    return YES;
    //}
    //
    //+(BOOL)resolveInstanceMethod:(SEL)sel
    //{
    //    return YES;
    //}
@end
