//
//  OYQNetworkBase.h
//  红满堂
//
//  Created by 欧阳铨 on 16/9/30.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OYQNetworkBase : NSObject
+ (void)postWithUrlString:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

+(void)getWithUrlString:(NSString *)url resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
