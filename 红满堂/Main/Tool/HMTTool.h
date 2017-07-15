//
//  HMTTool.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/26.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HMTTool : NSObject
+(UINavigationController *)getPushNavigation;
+(void)setBaseNavigationBarHidden:(BOOL)hidden animated:(BOOL)animate;
+(void)makeToast:(NSString *)str;
@end;
