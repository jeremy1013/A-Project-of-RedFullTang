//
//  HMTTokenTool.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTTokenTool.h"
#import "HMTTokenModel.h"
#import "HMTAppCache.h"
#import "HMTUserTool.h"
#import "HMTTool.h"


/// token
static NSString *sp_token = nil;
/// uid
static NSString *uid = nil;
/// mobile
static NSString *sp_mobile = nil;

@implementation HMTTokenTool
+ (void)saveTokenModel:(HMTTokenModel *)account{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:AccessTokenFilepath];
}

+ (NSString *)token{
    if (sp_token == nil) {
        // 读取账号
        HMTTokenModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccessTokenFilepath];
        
        // 判断账号是否过期
        NSDate *nowDate = [NSDate date];
        NSDate *date = [NSDate dateWithTimeInterval:[account.expires_in doubleValue] sinceDate:account.date];
        HMTLog(@"帐号过期时间%@",date);
        /// 如果左边时间小于右边
        if ([nowDate compare:[NSDate dateWithTimeInterval:[account.expires_in doubleValue] sinceDate:account.date]] != NSOrderedAscending) {// 过期
            if (account) {//存在用户模型，但是过期了
                [HMTTool makeToast:@"帐号过期，请重新登录"];
                NSNotification *notification = [[NSNotification alloc] initWithName:KNotificationLogOut object:nil userInfo:nil];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
            account = nil;
        }
        sp_token = account.access_token;
    }
    
    return sp_token;
}

+ (NSString *)uid{
    if (sp_token == nil) {
        // 读取账号
        HMTTokenModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccessTokenFilepath];
        
        // 判断账号是否过期
        NSDate *nowData = [NSDate date];
        
        /// 如果左边时间小于右边
        if ([nowData compare:[NSDate dateWithTimeIntervalSince1970:[account.expires_in doubleValue]]] != NSOrderedAscending) {// 过期
            account = nil;
        }
        sp_token = account.access_token;
        uid = account.uid;
    }
    
    return uid;
}


+ (BOOL)loginOut{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    BOOL fileExist=[[NSFileManager defaultManager] fileExistsAtPath:AccessTokenFilepath];
    [HMTAppCache clearCache];
    /// 清除内存中的token
    sp_token = nil;
    if (!fileExist) { // 找不到目录下的文件
        HMTLog(@"不存在Token文件");
        return NO;
    }else { // 找到token文件 做进行删除操作
        HMTLog(@"文件存在");
        BOOL filedDelete = [fileManager removeItemAtPath:AccessTokenFilepath error:nil];
        if (filedDelete) { // 删除文件成功,清空cookie，退出登录
            //删除用户模型
            [HMTUserTool deleteAccount];
            //发送登出的通知
            NSNotification *notification = [[NSNotification alloc] initWithName:KNotificationLogOut object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            //删除cookie
            NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            for (NSHTTPCookie *cookie in [storage cookies]) {
                [storage deleteCookie:cookie];
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
            return YES;
        }else { // 删除文件失败，注销登录
            return NO;
        }
    }
}

+ (void)saveMobilePhone:(NSString *)mobilePhone{
    [mobilePhone writeToFile:MobilePhoneFilepath atomically:NO encoding:NSUTF8StringEncoding error:nil];
    sp_mobile = mobilePhone;
}

+ (NSString *)mobilePhone{
    if (!sp_mobile) { // 如果内存中的mobile为nil，则从文件中读取
        NSString *mobilePhone = [NSString stringWithContentsOfFile:MobilePhoneFilepath encoding:NSUTF8StringEncoding error:nil];
        sp_mobile = mobilePhone;
    }
    return sp_mobile;
}

+(BOOL)isDownload{
    if ([HMTTokenTool token].length != 0) {
        return YES;
    }
    
    return NO;
}


@end
