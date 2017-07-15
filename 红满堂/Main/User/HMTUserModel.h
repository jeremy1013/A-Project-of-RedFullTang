//
//  HMTUserModel.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTUserModel : NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *adminid;
@property (nonatomic, copy) NSString *groupid;
//对应的groupid名
@property (nonatomic, copy) NSString *groupidName;
@property (nonatomic, strong) NSArray *extgroupids;
@property (nonatomic, copy) NSString *allowadmincp;
@property (nonatomic, copy) NSString *credits;
@property (nonatomic, copy) NSString *newpm;
@property (nonatomic, copy) NSString *ml;
@property (nonatomic, copy) NSString *sp;
@property (nonatomic, copy) NSString *avatar;
@end
