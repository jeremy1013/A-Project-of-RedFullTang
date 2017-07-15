//
//  HMTContainTableViewModel.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTContainTableViewModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
+ (instancetype)modelWithTitle:(NSString *)title imageNane:(NSString *)imagename;
@end
