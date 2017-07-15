//
//  HMTTabbarConfig.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/20.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HMTTabbarController.h"

@class HMTNavigationController;
@interface HMTTabbarConfig : NSObject
/** 自定义TabbarController*/
@property (nonatomic, strong, readonly)  HMTTabbarController *tabbarController;
/** 自定义NavigationController*/
//@property (nonatomic, strong, readonly)  HMTNavigationController *navigationController;
@end
