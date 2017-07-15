//
//  HMTTokenTool.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HMTTokenModel;
@interface HMTTokenTool : NSObject
/// 存储token
+ (void)saveTokenModel:(HMTTokenModel *)account;
/// 读取账号
+ (NSString *)token;
/// 读取uid
+ (NSString *)uid;

/**
 *  注销登录
 *
 *  @return YES:注销成功 NO:注销失败
 */
+ (BOOL)loginOut;

/**
 *  保存手机号码
 *
 *  @param mobilePhone 手机号码
 */
+ (void)saveMobilePhone:(NSString *)mobilePhone;

/**
 *  获得手机号码
 *
 *  @return 手机号码
 */
+ (NSString *)mobilePhone;
/**
 *  是否已经登录
 *
 *  @return BOOl
 */
+ (BOOL)isDownload;
@end
