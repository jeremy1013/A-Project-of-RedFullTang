//
//  HMTContainTableViewModel.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTContainTableViewModel.h"

@implementation HMTContainTableViewModel
+(instancetype)modelWithTitle:(NSString *)title imageNane:(NSString *)imageName{
    HMTContainTableViewModel *model = [[HMTContainTableViewModel alloc] init];
    model.title = title;
    model.imageName = imageName;
    return model;
}
@end
