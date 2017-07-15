//
//  HMTTabbarConfig.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/20.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTTabbarConfig.h"
#import "HMTTabbarItem.h"
#import "HMTTabbarController.h"
//#import "HMTNavigationController.h"

@interface HMTTabbarConfig()
@property (nonatomic, strong, readwrite)  HMTTabbarController *tabbarController;
//@property (nonatomic, strong, readwrite)  HMTNavigationController *navigationController;
@end

@implementation HMTTabbarConfig
- (HMTTabbarController *)tabbarController{
    
    if (!_tabbarController) {
        HMTTabbarItem *item0 = [HMTTabbarItem itemWithTitle:@"二手"];
        HMTTabbarItem *item1 = [HMTTabbarItem itemWithTitle:@"推荐"];
        HMTTabbarItem *item2 = [HMTTabbarItem itemWithTitle:@"分区"];
        HMTTabbarController *tabbarController = [[HMTTabbarController alloc] init];
        tabbarController.tabbarItems = @[item0, item1, item2];
        _tabbarController =tabbarController;
        
//        HMTNavigationController *nav = [[HMTNavigationController alloc] initWithRootViewController:tabbarController];
//        _navigationController = nav;
       
    }
    return _tabbarController;
}

@end
