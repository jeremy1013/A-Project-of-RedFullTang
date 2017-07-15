//
//  UIWindow+Extension.m
//  新浪微博
//
//  Created by 欧阳铨 on 15/10/18.
//  Copyright (c) 2015年 欧阳铨. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HMTBaseViewController.h"
#import "BaseNavigationController.h"

@implementation UIWindow (Extension)
-(void)switchRootViewController
{
//    NSString *versionKey = @"CFBundleVersion";
//    //取出上一次使用的版本号(存储在沙盒中的版本号)
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
//    //获得当前软件的版本号(从info.pilst中获得)
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
//    if ([currentVersion isEqualToString:lastVersion]) { //版本号相同
//        self.rootViewController = [[OYQTabBarController alloc] init];
//    }else{//版本号不一样
//        self.rootViewController = [[OYQNewFeatureViewController alloc] init];
//        //将版本号存进沙盒
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    HMTBaseViewController *vc = [[HMTBaseViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    self.rootViewController = nav;
}
@end
