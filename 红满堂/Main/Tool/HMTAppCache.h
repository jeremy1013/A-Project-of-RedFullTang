//
//  HMTAppCache.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTAppCache : NSObject
/**
 *  获得当前缓存的路径
 *
 *  @return app缓存的路径
 */
+ (NSString *)cacheDirectory;

/**
 *  清除文件缓存
 */
+ (void)clearCache;

/**
 *  根据缓存的文件名，创建对应的缓存路径
 *
 *  @param fileName 文件名
 *
 *  @return 文件名对应的路径
 */
+ (NSString *)pathCacheDirectoryWithFileName:(NSString *)fileName;
@end
