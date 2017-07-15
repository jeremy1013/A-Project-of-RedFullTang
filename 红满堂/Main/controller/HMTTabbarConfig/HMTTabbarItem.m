//
//  HMTTabbarItem.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/21.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTTabbarItem.h"

@implementation HMTTabbarItem
+(instancetype)itemWithTitle:(NSString *)title{
    HMTTabbarItem *item = [[HMTTabbarItem alloc] init];
    item.title = title;
    return item;
}
@end
