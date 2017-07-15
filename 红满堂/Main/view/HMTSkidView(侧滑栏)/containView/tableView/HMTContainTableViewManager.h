//
//  HMTContainTableViewManager.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMTContainTableView;
@interface HMTContainTableViewManager : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong, readonly) HMTContainTableView *HMTTableView;
+ (instancetype)shareManager;
@end