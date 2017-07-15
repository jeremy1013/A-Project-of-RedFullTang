//
//  HMTRecommendScrollBottomPageView.h
//  红满堂
//
//  Created by 欧阳铨 on 16/9/3.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat const kHMTRecommendScrollBottomPageViewCellWh = 20;

@interface HMTRecommendScrollBottomPageView : UIView
@property (nonatomic, strong) NSArray *models;
///当前页
@property (nonatomic, assign) NSInteger page;
@end
