//
//  HMTUserTool.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMTUserModel.h"

@interface HMTUserTool : NSObject
/// 存储model
+ (void)saveUserModel:(HMTUserModel *)account;
/// 读取账号
+ (HMTUserModel *)model;
/// 删除帐号
+ (BOOL)deleteAccount;
@end
