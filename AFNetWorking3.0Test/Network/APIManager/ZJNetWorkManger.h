//
//  ZJNetWorkManger.h
//  AFNetWorking3.0Test
//
//  Created by kunge on 16/3/21.
//  Copyright © 2016年 kunge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@protocol ZJMultipartFormData <AFMultipartFormData>


@end

@interface ZJNetWorkManger : AFHTTPSessionManager

/**
 *  获得 ELYNetworkManger 实例
 *
 *  @return ELYNetworkManger
 */
+ (nonnull instancetype)manager;

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
        failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;

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
        failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;


/**
 *  GET 请求
 *
 *  @param URLString     请求的URL
 *  @param parameters    请求参数，Model实例对象，例如：UserParameter的实例对象
 *  @param responseClass 请求成功，JSON对应的Model的Class，例如：[User class]
 *  @param downloadProgressBlock 请求成功下载加载进度回调Block
 *  @param successBlock  请求成功调用Block，Block中的responseObject参数，JSON对应的Model实例对象，例如：user
 *  @param failureBlock  请求失败调用Block
 */
- (void)zj_GET:(nonnull NSString *)URLString parameters:(nullable id)parameters responseClass:(nonnull Class)responseClass progress:(void (^ _Nullable)(NSProgress * _Nonnull progress))downloadProgressBlock
        success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
        failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;

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
           failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failureBlock;

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
           failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error))failureBlock;

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
           failure:(void (^ _Nonnull)(NSURLSessionDataTask *_Nonnull task, NSError *_Nonnull error))failureBlock;

/**
 *  POST 请求
 *
 *  @param URLString           请求URL
 *  @param responseClass       请求成功，JSON对应的Model的Class，例如：[User class]
 *  @param successBlock        请求成功回调Block
 *  @param failureBlock        请求失败回调Block
 */
- (void)zj_POST:(nonnull NSString *)URLString responseClass:(nonnull Class)responseClass
         success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
         failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;

/**
 *  POST 请求
 *
 *  @param URLString           请求URL
 *  @param parameters          请求参数，Model实例对象，例如：User的实例对象
 *  @param responseClass       请求成功，JSON对应的Model的Class，例如：[User class]
 *  @param successBlock        请求成功回调Block
 *  @param failureBlock        请求失败回调Block
 */
- (void)zj_POST:(nonnull NSString *)URLString parameters:(nullable id)parameters responseClass:(nonnull Class)responseClass
         success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
         failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;

/**
 *  POST 请求
 *
 *  @param URLString           请求URL
 *  @param parameters          请求参数，Model实例对象，例如：User的实例对象
 *  @param responseClass       请求成功，JSON对应的Model的Class，例如：[User class]
 *  @param uploadProgressBlock 请求成功加载进度回调Block
 *  @param successBlock        请求成功回调Block
 *  @param failureBlock        请求失败回调Block
 */
- (void)zj_POST:(nonnull NSString *)URLString parameters:(nullable id)parameters responseClass:(nonnull Class)responseClass
        progress:(void (^ _Nullable)(NSProgress * _Nullable progress))uploadProgressBlock
         success:(void (^ _Nonnull)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
         failure:(void (^ _Nonnull)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failureBlock;



@end
