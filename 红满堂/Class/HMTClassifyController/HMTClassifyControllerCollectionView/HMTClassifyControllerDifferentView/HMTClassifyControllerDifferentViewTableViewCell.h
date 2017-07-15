//
//  HMTClassifyControllerDifferentViewTableViewCell.h
//  红满堂
//
//  Created by Yuexi on 16/11/7.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMTClassifyControllerDifferentViewFrameModel;

@interface HMTClassifyControllerDifferentViewTableViewCell : UITableViewCell

@property (strong, nonatomic)  HMTClassifyControllerDifferentViewFrameModel *model;
+(instancetype)cellWithDic:(NSDictionary *)dic;
-(instancetype)initWithDic:(NSDictionary *)dic;

@end
