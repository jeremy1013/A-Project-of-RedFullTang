//
//  getClassifyViewModelReturn.m
//  红满堂
//
//  Created by Yuexi on 17/3/8.
//  Copyright © 2017年 欧阳铨. All rights reserved.
//

#import "getClassifyViewModelReturn.h"

@implementation getClassifyViewModelReturn
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"threads" : [HMTClassifyControllerDifferentViewModel class]
             };
}

@end
