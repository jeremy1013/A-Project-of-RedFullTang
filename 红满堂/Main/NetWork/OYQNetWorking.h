//
//  OYQNetWorking.h
//  myApp
//
//  Created by 欧阳铨 on 16/4/15.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



typedef  NS_ENUM(NSUInteger, OYQResponseType){ // 返回格式
    OYQResponseTypeJSON = 1, ///< 默认为JSON格式
    OYQResponseTypeXML = 2, ///< XML格式
    OYQResponseTypeData = 3
};

typedef NS_ENUM(NSUInteger, OYQRequestType) { // 请求格式
    OYQRequestTypeJSON = 1, ///< 默认JSON格式
    OYQRequestTypePlainText = 2 ///< text/html
};

typedef NS_ENUM(NSUInteger, OYQRequestCachePolicy) { /// 设置缓存策略
    OYQCacheRequestCachePolicyReturnCacheDataThenLoad = 0, ///< 先返回缓存，再同步请求数据
    OYQCacheRequestCachePolicyReloadIgnoringCacheData = 1, ///< 忽略本地缓存，重新发送网络请求
    OYQCacheRequestCachePolicyReturnCacheDataOrLoad = 2, ///< 有缓存就用缓存，没有缓存则重新发送请求（数据不变的时候使用）
    OYQCacheRequestCachePolicyCacheDataDontLoad = 3, ///< 有缓存则先用缓存，没有缓存就不发送请求，当错误处理
};

// 用OYQURLSessionDataTask来代替，减少对第三方的依赖
typedef NSURLSessionDataTask OYQURLSessionDataTask;
// 用OYQURLSessionDownloadTask来代替，减少对第三方的依赖
typedef NSURLSessionDownloadTask OYQURLSessionDownloadTask;

/**
 *  请求成功后的回调
 *
 *  @param response 服务器返回的数据类型，通常是字典
 */
typedef void(^OYQResponseSuccess)(id response);
/**
 *  请求失败后的回调
 *  网络响应失败后执行
 *  @param error 错误信息
 */
typedef void(^OYQResponseFail)(NSError *error);

/**
 *  当前的下载进度
 *
 *  @param bytesRead                已下载的大小
 *  @param totalBytesRead           文件总大小
 *  @param totalBytesExpectedToRead 还有需要下载的大小
 */
typedef void(^OYQDownloadProgress)(NSUInteger bytesRead,
                                   long long totalBytesRead,
                                   long long totalBytesExpectedToRead);

/**
 *  当前的上传进度
 *
 *  @param bytesRead                已下载的大小
 *  @param totalBytesRead           文件总大小
 *  @param totalBytesExpectedToRead 还有需要下载的大小
 */
typedef void(^OYQUpLoadProgress)(NSUInteger bytesRead,
                                 long long totalBytesRead,
                                 long long totalBytesExpectedToRead);
@interface OYQNetworking : NSObject
#pragma mark- 基础接口配置
/**
 *  用于指定网络请求接口的基础URL
 *  在AppDelegate中启动时设置一次
 *  例如：http://www.google.hk
 *  @param baseUrl 网络接口的基础URL
 */
+ (void)setUpBaseUrl:(NSString *)baseUrl;

/**
 *  获取到所设置的公共URL
 *
 *  @return 当前基础的URL
 */
+ (NSString *)baseUrl;

/**
 *  开启或关闭打印网络信息
 *
 *  @param isDebug 返回YES，及打印网络请求和返回的内容
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;

/**
 *  是否自动将URL使用UTF8编码
 *
 *  @param shouldAutoEncode YES or NO，默认为NO
 */
+ (void)shouldAutoEncodeUrl:(BOOL)shouldAutoEncode;

/**
 *  配置返回格式，默认为JSON。
 *  若是XML或者是其他格式需要在全局修改
 *
 *  @param responseType 响应格式
 */
+ (void)configResponseType:(OYQResponseType)responseType;

/**
 *  配置请求格式，默认为JSON
 *  若是XML或者是其他格式需要在全局修改
 *
 *  @param requestType 请求格式
 */
+ (void)configRequsetType:(OYQRequestType)requestType;

/**
 *  配置公共的请求头，只调用一次，在AppDelegate中配置
 *
 *  @param httpHeadersDict 传入服务器固定的参数的字典
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeadersDict;

#pragma mark - 一般情况下的GET请求和POST请求
/**
 *  GET请求接口
 *
 *  @param urlString 接口路径，拼接BaseUrl
 *  @param params    接口所需要提供的请求参数
 *  @param success   接口成功请求的数据回调
 *  @param fail      接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (OYQURLSessionDataTask *)getWithUrlString:(NSString *)urlString
                                  params:(NSDictionary *)params
                                 success:(OYQResponseSuccess)success
                                    fail:(OYQResponseFail)fail;

/**
 *  GET请求接口(无参数)
 *
 *  @param urlString 接口路径，拼接BaseUrl
 *  @param success   接口成功请求的数据回调
 *  @param fail      接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (OYQURLSessionDataTask *)getWithUrlString:(NSString *)urlString
                                 success:(OYQResponseSuccess)success
                                    fail:(OYQResponseFail)fail;

/**
 *  POST请求接口
 *  如果没有设置BaseUrl，可以传入完整的URL
 *
 *  @param urlString 接口路径，拼接BaseUrl
 *  @param params    接口所需要提供的请求参数
 *  @param success   接口成功请求的数据回调
 *  @param fail      接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (OYQURLSessionDataTask *)postWithUrlString:(NSString *)urlString
                                   params:(NSDictionary *)params
                                  success:(OYQResponseSuccess)success
                                     fail:(OYQResponseFail)fail;


/**
 *  POST请求接口,并对缓存做处理
 *
 *  @param urlString 接口路径，拼接BaseUrl
 *  @param params    接口所需要提供的请求参数
 *  @param cachePolicy 缓存策略选择
 *  @param success   接口成功请求的数据回调
 *  @param fail      接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (OYQURLSessionDataTask *)postWithUrlString:(NSString *)urlString
                                   params:(NSDictionary *)params
                          cacheDataPolicy:(OYQRequestCachePolicy)cachePolicy
                                  success:(OYQResponseSuccess)success
                                     fail:(OYQResponseFail)fail;

#pragma makr - 上传、下载请求
/**
 *  下载文件的请求
 *
 *  @param urlString     请求路径
 *  @param saveToPath    下载文件的路径
 *  @param progressBlock 下载进度
 *  @param success       下载成功后的回调
 *  @param failure       下载成功前的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (OYQURLSessionDownloadTask *)downloadWithUrlString:(NSString *)urlString
                                   saveToPath:(NSString *)saveToPath
                                     progress:(OYQDownloadProgress) progressBlock
                                      success:(OYQResponseSuccess)success
                                      failure:(OYQResponseFail) failure;

/**
 *  图片上传接口
 *
 *  @param image     图片对象
 *  @param urlString 上传图片的接口路径 eg:baseUrl/path/images/
 *  @param fileName  给定的文件名，默认为当前日期格式，"yyyyMMddHHmmss.jpg"
 *  @param name      与后台关联的指定文件名
 *  @param success   上传成功后的回调
 *  @param fail      上传失败后的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (OYQURLSessionDataTask *)uploadWithImage:(UIImage *)image
                              urlString:(NSString *)urlString
                               fileName:(NSString *)fileName
                                   name:(NSString *)name
                                success:(OYQResponseSuccess)success
                                   fail:(OYQResponseFail)fail;


/**
 *  图片上传接口、进度、额外参数
 *
 *  @param image     图片对象
 *  @param urlString 上传图片的接口路径 eg:baseUrl/path/images/
 *  @param fileName  给定的文件名，默认为当前日期格式，"yyyyMMddHHmmss.jpg"
 *  @param name      与后台关联的指定文件名
 *  @param parameters    其他参数设置
 *  @param progressBlock 上传进度
 *  @param success   上传成功后的回调
 *  @param fail      上传失败后的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (OYQURLSessionDataTask *)uploadWithImage:(UIImage *)image
                              urlString:(NSString *)urlString
                               fileName:(NSString *)fileName
                                   name:(NSString *)name
                             parameters:(NSDictionary *)parameters
                               progress:(OYQUpLoadProgress)progressBlock
                                success:(OYQResponseSuccess)success
                                   fail:(OYQResponseFail)fail;

/**
 *  图片上传接口、额外参数
 *
 *  @param image     图片对象
 *  @param urlString 上传图片的接口路径 eg:baseUrl/path/images/
 *  @param fileName  给定的文件名，默认为当前日期格式，"yyyyMMddHHmmss.jpg"
 *  @param name      与后台关联的指定文件名
 *  @param parameters    其他参数设置
 *  @param success   上传成功后的回调
 *  @param fail      上传失败后的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (OYQURLSessionDataTask *)uploadWithImage:(UIImage *)image
                              urlString:(NSString *)urlString
                               fileName:(NSString *)fileName
                                   name:(NSString *)name
                             parameters:(NSDictionary *)parameters
                                success:(OYQResponseSuccess)success
                                   fail:(OYQResponseFail)fail;

/**
 *  图片上传接口、进度
 *
 *  @param image     图片对象
 *  @param urlString 上传图片的接口路径 eg:baseUrl/path/images/
 *  @param fileName  给定的文件名，默认为当前日期格式，"yyyyMMddHHmmss.jpg"
 *  @param name      与后台关联的指定文件名
 *  @param progressBlock 上传进度
 *  @param success   上传成功后的回调
 *  @param fail      上传失败后的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (OYQURLSessionDataTask *)uploadWithImage:(UIImage *)image
                              urlString:(NSString *)urlString
                               fileName:(NSString *)fileName
                                   name:(NSString *)name
                               progress:(OYQUpLoadProgress)progressBlock
                                success:(OYQResponseSuccess)success
                                   fail:(OYQResponseFail)fail;
/**
 *  监听网络状态
 */
+ (void)AFNetworkStatus;
@end
