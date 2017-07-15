//
//  HMTSecondHandTableViewManager.h
//  红满堂
//
//  Created by 欧阳铨 on 16/9/18.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMTSecondHandTableView;
@interface HMTSecondHandTableViewManager : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong, readonly) HMTSecondHandTableView *HMTTableView;
+ (instancetype)shareManager;
@property (nonatomic, strong) NSArray *models;
@end
