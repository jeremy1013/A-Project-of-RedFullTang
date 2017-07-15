//
//  Oauth2Return.h
//  Oauth2
//
//  Created by 欧阳铨 on 16/8/20.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMTUserModel.h"
@interface Oauth2Return : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) HMTUserModel *data;

@end
