//
//  HMTTokenModel.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTTokenModel.h"

static NSString  * const KAccessTokenKey = @"AccessToken";
static NSString  * const KExpiresSecKey = @"ExpiresSec";
static NSString  * const KUidKey = @"Uid";
static NSString  * const KDateKey = @"Date";
@implementation HMTTokenModel
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:KAccessTokenKey];
        self.expires_in = [aDecoder decodeObjectForKey:KExpiresSecKey];
        self.uid = [aDecoder decodeObjectForKey:KUidKey];
        self.date = [aDecoder decodeObjectForKey:KDateKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)enCoder{
    [enCoder encodeObject:self.access_token forKey:KAccessTokenKey];
    [enCoder encodeObject:self.expires_in forKey:KExpiresSecKey];
    [enCoder encodeObject:self.uid forKey:KUidKey];
    [enCoder encodeObject:self.date forKey:KDateKey];
}

@end