//
//  HMTTabbarItem.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/21.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTTabbarItem : NSObject
@property (nonatomic, copy) NSString *title;

+(instancetype)itemWithTitle:(NSString *)title;
@end
