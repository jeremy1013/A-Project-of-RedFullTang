//
//  HMTTool.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/26.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTTool.h"
#import "OYQOauth2Controller.h"
#import "BaseNavigationController.h"

@implementation HMTTool
+(UINavigationController *)getPushNavigation{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    BaseNavigationController *nav = (BaseNavigationController *)keyWindow.rootViewController;
    return nav;
}

+(void)setBaseNavigationBarHidden:(BOOL)hidden animated:(BOOL)animate {
    UINavigationController *nav = [HMTTool getPushNavigation];
    UIViewController *view = nav.topViewController;
    
    [view.navigationController setNavigationBarHidden:hidden animated:animate];
}

+(void)makeToast:(NSString *)str{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UINavigationController *nav = (UINavigationController *)keyWindow.rootViewController;
    [nav.view makeToast:str];
}
@end
