//
//  HMTSecondHandDetailTitleView.h
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/13.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>


@class getGoodsDetailReturn;
@interface HMTSecondHandDetailTitleView : UIView
+ (instancetype)title;
@property (nonatomic, strong) getGoodsDetailReturn *model;
@end
