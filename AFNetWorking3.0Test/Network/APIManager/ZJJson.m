//
//  ZJJson.m
//  AFNetWorking3.0Test
//
//  Created by kunge on 16/3/21.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "ZJJson.h"
#import <MJExtension.h>

@implementation ZJJson

/**
 *  将JSON字符串映射成对应的Model实例
 *
 *  @param JSONString       JSON字符串
 *  @param destinationClass JSON字符串映射的Model类
 *
 *  @return 返回Model实例
 */
+ (nullable id)zj_fromJson:(nonnull NSString *)JSONString class:(nonnull Class)destinationClass {
    
    return [destinationClass mj_objectWithKeyValues:JSONString];
}

/**
 *  将NSDictionary映射成对应的Model实例
 *
 *  @param dictionary       dictionary
 *  @param destinationClass dictionary映射的Model类
 *
 *  @return 返回Model实例
 */
+ (nullable id)zj_fromDictionary:(nonnull NSDictionary *)dictionary class:(nonnull Class)destinationClass {
    
    return [destinationClass mj_objectWithKeyValues:dictionary];
}

/**
 *  将Model实例映射成NSDictionary
 *
 *  @param obj Model实例
 *
 *  @return 返回NSDictionary
 */
+ (nullable NSDictionary *)zj_toDictionaryWithObject:(nonnull id)obj {
    return [obj mj_keyValues];
}

/**
 *  转换成JSON字符串
 *
 *  @param obj Model对象
 *
 *  @return 返回JSON字符串
 */
+ (nullable NSString *)zj_JSONStringWithObject:(nonnull id)obj {
    return [obj mj_JSONString];
}




@end
