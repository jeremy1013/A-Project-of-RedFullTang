//
//  HMTSecondHandDeviceModel.h
//  红满堂
//
//  Created by Yuexi on 16/11/22.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTSecondHandDeviceModel : NSObject
@property (strong, nonatomic)  NSString *tittle;
@property (strong, nonatomic)  NSString *price;
@property (strong, nonatomic)  NSString *date;
@property (strong, nonatomic)  NSString *viewCount;
+(instancetype)modelWithDic:(NSDictionary *)dic;
@end
