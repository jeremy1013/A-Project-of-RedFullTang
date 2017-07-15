//
//  HMTTabbarController.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/26.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTTabbarController : UIViewController
@property (nonatomic, strong, readonly) UIView *tabbar;
/** childViewControllers*/
@property (nonatomic, strong) NSArray *viewControllers;
/** */
@property (nonatomic, strong) NSArray *tabbarItems;

@property (nonatomic, strong) UIColor *tabbarColor;
@end
