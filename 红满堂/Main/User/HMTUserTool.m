//
//  HMTUserTool.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTUserTool.h"
#import "HMTAppCache.h"

static HMTUserModel *model = nil;

@implementation HMTUserTool
+ (void)saveUserModel:(HMTUserModel *)account{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:UserModelFilepath];
}

+ (HMTUserModel *)model{
    if (model == nil) {
        // 读取账号
        HMTUserModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:UserModelFilepath];
        model = userModel;
    }
    return model;
}

+(BOOL)deleteAccount{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    BOOL fileExist=[[NSFileManager defaultManager] fileExistsAtPath:UserModelFilepath];
    [HMTAppCache clearCache];
    if (!fileExist) { // 找不到目录下的文件
        HMTLog(@"不存在帐号文件");
        return NO;
    }else { // 找到帐号文件 做进行删除操作
        HMTLog(@"帐号文件存在");
        BOOL filedDelete = [fileManager removeItemAtPath:UserModelFilepath error:nil];
        if (filedDelete) { // 删除文件成功
            HMTLog(@"帐号删除成功");
            model = nil;
            return YES;
        }else { // 删除文件失败
            return NO;
        }
    }}


@end
