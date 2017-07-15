//
//  HMTSecondHandTableView.h
//  红满堂
//
//  Created by 欧阳铨 on 16/9/18.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMTSecondHandTableViewManager.h"

static NSString *const kHMTSecondHandTableViewCellIdentifier = @"HMTSecondHandTableViewCell";
@interface HMTSecondHandTableView : UITableView
@property (nonatomic, strong) NSArray *models;
@end
