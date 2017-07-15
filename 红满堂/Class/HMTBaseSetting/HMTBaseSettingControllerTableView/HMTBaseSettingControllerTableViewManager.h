//
//  HMTBaseSettingControllerTableViewManager.h
//  红满堂
//
//  Created by 欧阳铨 on 16/9/1.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMTBaseSettingControllerTableView;
@interface HMTBaseSettingControllerTableViewManager : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong, readonly) HMTBaseSettingControllerTableView *spTableView;
+ (instancetype)shareManager;
@end
