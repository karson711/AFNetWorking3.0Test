//
//  ZJNetWorkManger.m
//  AFNetWorking3.0Test
//
//  Created by kunge on 16/3/21.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import "ZJNetWorkManger.h"
#import <MJExtension.h>
#import "ZJJson.h"

/// StatusCode  Begin
// 是否需要处理响应的 StatusCode
// statusCode = 0;
#define ZJNetworkManager_NeedHandleResponseResult_StatusCode 1

#define ZJNetworkManager_NeedHandleResponseResult_StatusCode_KeyWords @"statusCode"
// "statusCode":0
// 需要处理API返回数据正常状态的字符串，正确的："statusCode":0 ;  错误的：非 0 ，例如： "statusCode":500 ， statusCode = 404
#define ZJNetworkManager_NeedHandleResponseResult_StatusCode_Value @"\"statusCode\":0"

/// StatusCode  End

// 需要处理只返回目标Model   Begin
#define ZJNetworkManager_NeedHandleResponseDestinationModel 1
// 需要处理只返回目标Model   End



@implementation ZJNetWorkManger


+ (instancetype)manager {
    static ZJNetWorkManger *manager = nil;
    
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        
        //[NSURL URLWithString:[ProjectOption shareInstance].projectBaseURL]
        NSURL *url = [NSURL URLWithString:@"http://172.18.107.96:8081/"];
        manager = [[self alloc] initWithBaseURL:url];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    });
    
    return manager;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
//        NSLog(@"initWithBaseURL # url=%@", url);

    }
    return self;
}

/**
 *  GET 请求
 *
 *  @param URLString     请求的URL
 *  @param responseClass 请求成功，JSON对应的Model的Class，例如：[User class]
 *  @param successBlock  请求成功调用Block，Block中的responseObject参数，JSON对应的Model实例对象，例如：user
 *  @param failureBlock  请求失败调用Block
 */
- (void)zj_GET:(nonnull NSString *)URLString responseClass:(nonnull Class)responseClass
        success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
        failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock {
    [self zj_GET:URLString parameters:nil responseClass:responseClass success:successBlock failure:failureBlock];
}

/**
 *  GET 请求
 *
 *  @param URLString     请求的URL
 *  @param parameters    请求参数，Model实例对象，例如：User的实例对象
 *  @param responseClass 请求成功，JSON对应的Model的Class，例如：[User class]
 *  @param successBlock  请求成功调用Block，Block中的responseObject参数，JSON对应的Model实例对象，例如：user
 *  @param failureBlock  请求失败调用Block
 */
- (void)zj_GET:(nonnull NSString *)URLString parameters:(nullable id)parameters responseClass:(nonnull Class)responseClass
        success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
        failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock {
    [self zj_GET:URLString parameters:parameters responseClass:responseClass progress:nil success:successBlock failure:failureBlock];
}


/**
 *  GET 请求
 *
 *  @param URLString     请求的URL
 *  @param parameters    请求参数，字典
 *  @param responseClass 请求成功，JSON对应的Model的Class，例如：[User class]
 *  @param downloadProgressBlock 请求成功下载加载进度回调Block
 *  @param successBlock  请求成功调用Block，Block中的responseObject参数，JSON对应的Model实例对象，例如：user
 *  @param failureBlock  请求失败调用Block
 */
- (void)zj_GET:(nonnull NSString *)URLString parameters:(nullable id)parameters responseClass:(nonnull Class)responseClass progress:(void (^ _Nullable)(NSProgress * _Nonnull progress))downloadProgressBlock
        success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
        failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock {
    
    
    [self GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (downloadProgressBlock) {
            downloadProgressBlock(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *description = [ZJJson zj_JSONStringWithObject:responseObject];
        NSString *error = [self previousHandleWithString:description];
        if (error) {
            if (failureBlock) {
                failureBlock(task, [NSError errorWithDomain:@"请查看API返回状态码" code:404 userInfo:@{ @"error" : error }]);
            }
            return;
        }
        
        [self handleResponseWithJSON:description responseClass:responseClass responseObject:responseObject task:task success:successBlock];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failureBlock) {
            failureBlock(task, error);
        }
    }];
}

/**
 *  Upload 上传
 *
 *  @param URLString           请求URL
 *  @param block               结构体(上传文件)回调Block
 *  @param successBlock        上传成功回调Block
 *  @param failureBlock        上传失败回调Block
 */
- (void)zj_UPLOAD:(nonnull NSString *)URLString
constructingBodyWithBlock:(void (^ _Nonnull)(id<ZJMultipartFormData> _Nonnull))block
           success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject))successBlock
           failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failureBlock {
    [self zj_UPLOAD:URLString parameters:nil constructingBodyWithBlock:block success:successBlock failure:failureBlock];
}

/**
 *  Upload 上传
 *
 *  @param URLString           请求URL
 *  @param parameters          请求参数，Model实例对象，例如：User的实例对象
 *  @param block               结构体(上传文件)回调Block
 *  @param successBlock        上传成功回调Block
 *  @param failureBlock        上传失败回调Block
 */
- (void)zj_UPLOAD:(nonnull NSString *)URLString
        parameters:(nullable id)parameters
constructingBodyWithBlock:(void (^ _Nonnull)(id<ZJMultipartFormData> _Nonnull))block
           success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject))successBlock
           failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failureBlock {
    [self zj_UPLOAD:URLString parameters:parameters constructingBodyWithBlock:block progress:nil success:successBlock failure:failureBlock];
}

/**
 *  Upload 上传
 *
 *  @param URLString           请求URL
 *  @param parameters          请求参数，Model实例对象，例如：User的实例对象
 *  @param block               结构体(上传文件)回调Block
 *  @param uploadProgressBlock 上传进度回调Block
 *  @param successBlock        上传成功回调Block
 *  @param failureBlock        上传失败回调Block
 */
- (void)zj_UPLOAD:(nonnull NSString *)URLString
        parameters:(nullable id)parameters
constructingBodyWithBlock:(void (^ _Nonnull)(id <ZJMultipartFormData> _Nonnull))block
          progress:(void (^ _Nullable)(NSProgress * _Nullable progress))uploadProgressBlock
           success:(void (^ _Nonnull)(NSURLSessionDataTask *_Nonnull task, id _Nonnull responseObject))successBlock
           failure:(void (^ _Nonnull)(NSURLSessionDataTask *_Nonnull task, NSError *_Nonnull error))failureBlock {
    
    
    [self POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (block) {
            block((id<ZJMultipartFormData>)formData);
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(task, error);
        }
        
    }];
}

/**
 *  POST 请求
 *
 *  @param URLString           请求URL
 *  @param responseClass       请求成功，字典
 *  @param successBlock        请求成功回调Block
 *  @param failureBlock        请求失败回调Block
 */
- (void)zj_POST:(nonnull NSString *)URLString responseClass:(nonnull Class)responseClass
         success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
         failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock {
    
    [self zj_POST:URLString parameters:nil responseClass:responseClass success:successBlock failure:failureBlock];
}

/**
 *  POST 请求
 *
 *  @param URLString           请求URL
 *  @param parameters          请求参数，字典
 *  @param responseClass       请求成功，JSON对应的Model的Class，例如：[User class]
 *  @param successBlock        请求成功回调Block
 *  @param failureBlock        请求失败回调Block
 */
- (void)zj_POST:(nonnull NSString *)URLString parameters:(nullable id)parameters responseClass:(nonnull Class)responseClass
         success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
         failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock {
    [self zj_POST:URLString parameters:parameters responseClass:responseClass progress:nil success:successBlock failure:failureBlock];
}

/**
 *  POST 请求
 *
 *  @param URLString           请求URL
 *  @param parameters          请求参数，字典
 *  @param responseClass       请求成功，JSON对应的Model的Class，例如：[User class]
 *  @param uploadProgressBlock 请求成功加载进度回调Block
 *  @param successBlock        请求成功回调Block
 *  @param failureBlock        请求失败回调Block
 */
- (void)zj_POST:(nonnull NSString *)URLString parameters:(nullable id)parameters responseClass:(nonnull Class)responseClass
        progress:(void (^ _Nullable)(NSProgress * _Nullable progress))uploadProgressBlock
         success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
         failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock {
    NSLog(@"URLString====%@",URLString);
    [self POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
        if (uploadProgressBlock) {
            uploadProgressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *description = [ZJJson zj_JSONStringWithObject:responseObject];
        NSLog(@"description====%@",description);
        NSString *error = [self previousHandleWithString:description];
        if (error) {
            
            if (failureBlock) {
                failureBlock(task, [NSError errorWithDomain:@"请查看API返回状态码" code:404 userInfo:@{ @"error" : error }]);
            }
            return;
        }
        [self handleResponseWithJSON:description responseClass:responseClass responseObject:responseObject task:task success:successBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failureBlock) {
            failureBlock(task, error);
        }
    }];
}


/**
 *  预处理
 *
 *  @param JSONString 字符串
 *
 *  @return 返回处理信息
 */
- (NSString *)previousHandleWithString:(NSString *)JSONString {
    
    NSString *description = JSONString;
    
    if (ZJNetworkManager_NeedHandleResponseResult_StatusCode) {
        
        NSRange range = [description rangeOfString:ZJNetworkManager_NeedHandleResponseResult_StatusCode_Value];
        
        if (range.location == NSNotFound) {
            
            NSRange range2 = [description rangeOfString:ZJNetworkManager_NeedHandleResponseResult_StatusCode_KeyWords];
            
            if (range2.length) {
                
                description = [description substringFromIndex:range2.location];
                
                NSRange range3 = [description rangeOfString:@";" options:NSBackwardsSearch];
                
                if (range3.length) {
                    
                    NSString *error = [description substringToIndex:range3.location + range3.length - 1];
                    return error;
                }
                
                return description;
            }
        }
    }
    
    return nil;
}

/**
 *  处理响应数据
 */
- (void)handleResponseWithJSON:(NSString *)description responseClass:(nonnull Class)responseClass responseObject:(nullable id)responseObject task:(NSURLSessionDataTask * _Nonnull)task success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock{
    if (successBlock){
        
        if (responseClass) {
            if (ZJNetworkManager_NeedHandleResponseDestinationModel) {
                NSRange range1 = [description rangeOfString:@"{"];
                if (range1.length) {
                    description = [description stringByReplacingCharactersInRange:range1 withString:@""];
                    
                    NSRange range2 = [description rangeOfString:@"}" options:NSBackwardsSearch];
                    
                    if (range2.length) {
                        description = [description stringByReplacingCharactersInRange:range2 withString:@""];
                        
                        range1 = [description rangeOfString:@"{"];
                        if (range1.length && range2.length) {
                            description = [description substringFromIndex:range1.location];
                            range2 = [description rangeOfString:@"}" options:NSBackwardsSearch];
                            if (range2.length) {
                                NSString *json = [description substringToIndex:range2.location + 1];
                                
                                successBlock(task, [ZJJson zj_fromJson:json class:responseClass]);
                                return;
                            }
                        }
                    }
                }
            }
            successBlock(task, [responseClass mj_objectWithKeyValues:responseObject]);
        } else {
            successBlock(task, responseObject);
        }
    }
}




@end
