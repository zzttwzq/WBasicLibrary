//
//  NSArray+WHander.h
//  AFNetworking
//
//  Created by 吴志强 on 2019/1/14.
//

#import <Foundation/Foundation.h>
#import "MicroDefinetion.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (WHander)

/**
 安全的取出数组内容

 @param index 下标
 @return 返回数组内容
 */
- (id) safeObjectAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
