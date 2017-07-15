//
//  OYQNetworkBase.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/30.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//


#import "OYQNetworkBase.h"
#import "OYQNetWorking.h"
#import <YYModel.h>

@implementation OYQNetworkBase
+ (void)postWithUrlString:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    // 把模型转化为字典
    NSDictionary *params = [param yy_modelToJSONObject];
    [OYQNetworking postWithUrlString:url params:params cacheDataPolicy:OYQCacheRequestCachePolicyReturnCacheDataThenLoad success:^(id response) {
        if (success) {
            id result = [resultClass yy_modelWithJSON:response];
            
            success(result);
        }
    } fail:^(NSError *error) {
        if (failure) {
            NSString *errorDesc = [error description];
            NSLog(@"请求失败%@",errorDesc);
            failure(error);
        }
    }];
}

+(void)getWithUrlString:(NSString *)url resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [OYQNetworking getWithUrlString:url success:^(id response) {
        if (success) {
            //模型转换
            id result = [resultClass yy_modelWithJSON:response];
            success(result);
        }
    } fail:^(NSError *error) {
        if (failure) {
            NSString *errorDesc = [error description];
            NSLog(@"请求失败%@",errorDesc);
            failure(error);
        }
    }];
}

@end
