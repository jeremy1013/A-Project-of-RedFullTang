//
//  HMTSecondHandDeviceModel.m
//  红满堂
//
//  Created by Yuexi on 16/11/22.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandDeviceModel.h"

@implementation HMTSecondHandDeviceModel

+(instancetype)modelWithDic:(NSDictionary *)dic{
    HMTSecondHandDeviceModel *model = [HMTSecondHandDeviceModel new];
    
    model.tittle = [dic valueForKey:@"secondgoods_name"];
    model.price = [dic valueForKey:@"secondgoods_price"];
    model.date = [dic valueForKey:@"secondgoods_postdate"];
    model.viewCount = [dic valueForKey:@"secondgoods_views"];
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
