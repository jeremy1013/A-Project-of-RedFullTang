//
//  OYQNetWorking.m
//  myApp
//
//  Created by 欧阳铨 on 16/4/15.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "OYQNetWorking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <AFHTTPSessionManager.h>
#import "HMTTool.h"
#if __has_include(<YYCache/YYCache.h>)
#import <YYCache.h>
#endif

/// 基础的网络URL
static NSString *privateNetworkBaseUrl = nil;
/// 是否打印网络请求的内容，默认为YES
static BOOL isEnableInterfaceDebug = YES;
/// 是否转换为UTF8编码，默认为NO
static BOOL shouldAutoEncode = NO;
/// 请求体格式，默认为JSON
static OYQRequestType iRequestType = OYQRequestTypeJSON;
/// 响应体格式，默认为JSON
static OYQResponseType iResponseType = OYQResponseTypeJSON;
/// 公共请求头
static NSDictionary *iHttpHeaders = nil;
/// 缓存标识
static NSString * const OYQRequestCache = @"OYQRequestCache";
// 调试的时候用的打印日志
#ifdef DEBUG
#define OYQAppLog(s, ... ) NSLog( @"[%@：in line: %d]-->[message: %@]", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define OYQAppLog(s, ... )
#endif
@implementation OYQNetworking
#pragma mark - 公共配置部分
+ (void)setUpBaseUrl:(NSString *)baseUrl{
    privateNetworkBaseUrl = baseUrl;
}

+ (NSString *)baseUrl{
    return privateNetworkBaseUrl;
}

+ (void)enableInterfaceDebug:(BOOL)isDebug{
    isEnableInterfaceDebug = isDebug;
}

+ (BOOL)isDebug{
    return isEnableInterfaceDebug;
}

+ (void)shouldAutoEncodeUrl:(BOOL)autoEncode{
    shouldAutoEncode = autoEncode;
}

+ (BOOL)shouldEncode{
    return shouldAutoEncode;
}

+ (void)configRequsetType:(OYQRequestType)requestType{
    iRequestType = requestType;
}

+ (void)configResponseType:(OYQResponseType)responseType{
    iResponseType = responseType;
}

+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeadersDict{
    iHttpHeaders = httpHeadersDict;
}

#pragma mark - 请求方法
+ (OYQURLSessionDataTask *)getWithUrlString:(NSString *)urlString
                                  params:(NSDictionary *)params
                                 success:(OYQResponseSuccess)success
                                    fail:(OYQResponseFail)fail {
    if ([self shouldEncode]) {
        urlString = [self encodeUrlString:urlString];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *dataTask =  [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successResponse:responseObject callBack:success];
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject urlString:urlString params:params];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
        if ([self isDebug]) {
            [self logWithFailError:error urlString:urlString params:params];
        }
    }];
    
    [dataTask resume];
    return dataTask;
}

+ (OYQURLSessionDataTask *)postWithUrlString:(NSString *)urlString
                                      params:(NSDictionary *)params
                               cacheInstance:(YYCache *)cache
                                     success:(OYQResponseSuccess)success
                                        fail:(OYQResponseFail)fail{
    if ([self shouldEncode]) {
        urlString = [self encodeUrlString:urlString];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *dataTask =  [manager POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印进度
        NSLog(@"%lf",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (cache) {
            NSString *cacheKey = [self cacheDataUrlStringToCacheKey:urlString];
            //YYCache 已经做了responseObject为空处理
            [cache setObject:responseObject forKey:cacheKey];
        }
        [self successResponse:responseObject callBack:success];
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject urlString:urlString params:params];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
        if ([self isDebug]) {
            [self logWithFailError:error urlString:urlString params:params];
        }
    }];

    [dataTask resume];
    return dataTask;
}

+ (OYQURLSessionDataTask *)getWithUrlString:(NSString *)urlString
                                 success:(OYQResponseSuccess)success
                                    fail:(OYQResponseFail)fail{
    return [self getWithUrlString:urlString params:nil success:success fail:fail];
}

+ (OYQURLSessionDataTask *)postWithUrlString:(NSString *)urlString
                                   params:(NSDictionary *)params
                                  success:(OYQResponseSuccess)success
                                     fail:(OYQResponseFail)fail{
    return [self postWithUrlString:urlString params:params cacheInstance:nil success:success fail:fail];
}

#pragma mark - 缓存处理
+ (OYQURLSessionDataTask *)postWithUrlString:(NSString *)urlString
                                   params:(NSDictionary *)params
                          cacheDataPolicy:(OYQRequestCachePolicy)cachePolicy
                                  success:(OYQResponseSuccess)success
                                     fail:(OYQResponseFail)fail{
    // 用url来做cache的key
    NSString *cacheKey = [self cacheDataUrlStringToCacheKey:urlString];
    // 创建cache
    YYCache *cache = [[YYCache alloc] initWithName:OYQRequestCache];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    
    id object = [cache objectForKey:cacheKey];
    
    switch (cachePolicy) {
        case OYQCacheRequestCachePolicyReturnCacheDataThenLoad: { /// 先加载缓存再做同步请求
            if (object) {
                success(object);
            }
            break;
        }
        case OYQCacheRequestCachePolicyReloadIgnoringCacheData: { /// 忽略本地缓存，重新发送网络请求
            // 直接发送网络请求
            break;
        }
        case OYQCacheRequestCachePolicyReturnCacheDataOrLoad: { /// 有缓存就直接用缓存，没有缓存再请求
            if(object){
                success(object);
                return nil;
            }
            break;
        }
        case OYQCacheRequestCachePolicyCacheDataDontLoad: { /// 有缓存则先用缓存，没有缓存就不发送请求，当错误处理
            if (object) {
                success(object);
            }
            return nil;
            break;
        }
    }
    return [self postWithUrlString:urlString params:params cacheInstance:cache success:success fail:fail];
}

+ (OYQURLSessionDownloadTask *)downloadWithUrlString:(NSString *)urlString
                                   saveToPath:(NSString *)saveToPath
                                     progress:(OYQDownloadProgress)progressBlock
                                      success:(OYQResponseSuccess)success
                                      failure:(OYQResponseFail)failure{
    //1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.确定请求的URL地址
    NSURL *url = [NSURL URLWithString:urlString];
    
    //3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //打印下下载进度
        NSLog(@"%lf",1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //下载地址
        NSLog(@"默认下载地址:%@",targetPath);
        
        //设置下载路径，通过沙盒获取缓存地址，最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return [NSURL URLWithString:filePath];
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                failure(error);
            }
        }else{
            if (success) { // 返回下载到的路径
                success(saveToPath);
            }
        }
        
    }];
    
    //开始启动任务
    [task resume];
    
    return task;
}

#pragma mark - 图片上传接口
+ (OYQURLSessionDataTask *)uploadWithImage:(UIImage *)image
                              urlString:(NSString *)urlString
                               fileName:(NSString *)fileName
                                   name:(NSString *)name
                             parameters:(NSDictionary *)parameters
                               progress:(OYQUpLoadProgress)progressBlock
                                success:(OYQResponseSuccess)success
                                   fail:(OYQResponseFail)fail{
    if ([self shouldEncode]) {
        urlString = [self encodeUrlString:urlString];
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLSessionDataTask *dataTask = [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /// -----------------------------在这里更改图片的格式------------------------------------
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        NSString *imageFileName = fileName;
        if (fileName == nil || ![fileName isKindOfClass:[NSString class]] || fileName.length == 0) {
            NSDateFormatter *formatter = [NSDateFormatter new];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [str stringByAppendingString:@".jpg"];
        }
        
        // 二进制流格式上传图片
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successResponse:responseObject callBack:success];
        
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject urlString:urlString params:parameters];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
        
        if ([self isDebug]) {
            [self logWithFailError:error urlString:urlString params:parameters];
        }
    }];
    [dataTask resume];
    
    return dataTask;
}

+ (OYQURLSessionDataTask *)uploadWithImage:(UIImage *)image
                              urlString:(NSString *)urlString
                               fileName:(NSString *)fileName
                                   name:(NSString *)name
                                success:(OYQResponseSuccess)success
                                   fail:(OYQResponseFail)fail{
    return [self uploadWithImage:image urlString:urlString fileName:fileName name:name parameters:nil progress:nil success:success fail:fail];
}

+ (OYQURLSessionDataTask *)uploadWithImage:(UIImage *)image
                              urlString:(NSString *)urlString
                               fileName:(NSString *)fileName
                                   name:(NSString *)name
                             parameters:(NSDictionary *)parameters
                                success:(OYQResponseSuccess)success
                                   fail:(OYQResponseFail)fail{
    return [self uploadWithImage:image urlString:urlString fileName:fileName name:name parameters:parameters progress:nil success:success fail:fail];
}

+ (OYQURLSessionDataTask *)uploadWithImage:(UIImage *)image
                              urlString:(NSString *)urlString
                               fileName:(NSString *)fileName
                                   name:(NSString *)name
                               progress:(OYQUpLoadProgress)progressBlock
                                success:(OYQResponseSuccess)success
                                   fail:(OYQResponseFail)fail{
    return [self uploadWithImage:image urlString:urlString fileName:fileName name:name parameters:nil progress:progressBlock success:success fail:fail];
}
#pragma mark - 2.0中私有方法
//+ (AFHTTPRequestOperationManager *) manager{
//    // 开启转圈圈
//    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
//    
//    // 初始化
//    AFHTTPRequestOperationManager *manager = nil;
//    
//    if ([self baseUrl] != nil) { // 如果有baseUrl 设置为Manager的默认URL
//        manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
//    }else{ // 没有baseUrl 初始化Manager
//        manager = [AFHTTPRequestOperationManager manager];
//    }
//    
//    // 设置请求内容解析
//    switch (iRequestType) {
//        case OYQRequestTypeJSON: {
//            manager.requestSerializer = [AFJSONRequestSerializer serializer];
//            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//            [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//            break;
//        }
//        case OYQRequestTypePlainText: {
//            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//            break;
//        }
//    }
//    
//    // 设置返回内容格式解析
//    switch (iResponseType) {
//        case OYQResponseTypeJSON: {
//            manager.responseSerializer = [AFJSONResponseSerializer serializer];
//            break;
//        }
//        case OYQResponseTypeXML: {
//            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
//            break;
//        }
//        case OYQResponseTypeData: {
//            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//            break;
//        }
//    }
//    
//    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
//    
//    for (NSString *key in iHttpHeaders.allKeys) {
//        if (iHttpHeaders[key] != nil) {
//            [manager.requestSerializer setValue:iHttpHeaders[key] forKey:key];
//        }
//    }
//    
//    // 设置解析内容的格式
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
//                                                                              @"text/html",
//                                                                              @"text/json",
//                                                                              @"text/plain",
//                                                                              @"text/javascript",
//                                                                              @"text/xml",
//                                                                              @"image/*"]];
//    // 设置允许的最大并发数量为3
//    manager.operationQueue.maxConcurrentOperationCount = 3;
//    return manager;
//}

+ (NSString *)encodeUrlString:(NSString *)urlString{
    return [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (void)logWithSuccessResponse:(id)response urlString:(NSString *)urlString params:(NSDictionary *)params {
    OYQAppLog(@"🍏\n Url: %@ \n params:%@ \n response:%@\n🍏",
              urlString,
              params,
              [self tryToParseData:response]);
}

+ (void)logWithFailError:(NSError *)error urlString:(NSString *)urlString params:(NSDictionary *)params {
    OYQAppLog(@"🍎\n Url: %@ \n params:%@ \n errorInfo:%@\n🍎",
              urlString,
              params,
              [error localizedDescription]);
}

+ (id)tryToParseData:(id)responseData {
    if ([responseData isKindOfClass:[NSData class]]) {
        // 尝试解析成JSON
        if (responseData == nil) {
            return responseData;
        } else{
            NSError *error = nil;
            NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
            
            if (error != nil) {
                return responseData;
            } else{
                return response;
            }
        }
    } else {
        return responseData;
    }
}

+ (void)successResponse:(id)responseData callBack:(OYQResponseSuccess) success{
    if (success) {
        success([self tryToParseData:responseData]);
    }
}


+ (NSString *)cacheDataUrlStringToCacheKey:(NSString *)urlString{
    NSRange range = [urlString rangeOfString:@"?"];
    if (range.length) {
        return [urlString substringToIndex:range.location];
    }else{
        return urlString;
    }
}

/**
 *  监听网络状态
 */
+ (void)AFNetworkStatus{
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
    }];
}

@end
