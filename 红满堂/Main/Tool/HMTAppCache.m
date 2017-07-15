//
//  HMTAppCache.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTAppCache.h"

#define AppChacheFilePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"AppChache"]
@implementation HMTAppCache
+ (NSString *)cacheDirectory{
    return AppChacheFilePath;
}

+ (NSString *)pathCacheDirectoryWithFileName:(NSString *)fileName{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    // 判断文件夹是否存在Cache，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:AppChacheFilePath]) {
        [fileManager createDirectoryAtPath:AppChacheFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        HMTLog(@"FileDir is exists.");
    }
    return [AppChacheFilePath stringByAppendingPathComponent:fileName];
}

+ (void)clearCache{
    BOOL deletePath = [[NSFileManager defaultManager] removeItemAtPath:AppChacheFilePath error:nil];
    HMTLog(@"删除缓存文件夹 %d",deletePath);
}
@end
