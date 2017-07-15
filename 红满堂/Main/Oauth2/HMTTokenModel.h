//
//  HMTTokenModel.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTTokenModel : NSObject
///token
@property (nonatomic, copy) NSString *access_token;
///失败秒数
@property (nonatomic, copy) NSString *expires_in;
///用户uid
@property (nonatomic, copy) NSString *uid;
///登录成功的时间
@property (nonatomic, strong) NSDate *date;
@end