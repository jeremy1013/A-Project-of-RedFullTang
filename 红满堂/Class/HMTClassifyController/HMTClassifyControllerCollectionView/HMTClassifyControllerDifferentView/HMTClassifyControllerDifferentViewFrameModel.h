//
//  HMTClassifyControllerDifferentViewFrameModel.h
//  红满堂
//
//  Created by Yuexi on 16/11/8.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HMTClassifyControllerDifferentViewModel;

@interface HMTClassifyControllerDifferentViewFrameModel : NSObject

@property (strong, nonatomic)  HMTClassifyControllerDifferentViewModel *model;
@property (strong, nonatomic)  NSString *tid;
@property (strong, nonatomic)  NSString *imaView;
@property (strong, nonatomic)  NSString *name;
@property (strong, nonatomic)  NSString *tittle;
@property (strong, nonatomic)  NSString *text;
@property (strong, nonatomic)  NSString *reply;
@property (strong, nonatomic)  NSString *date;
@property (strong, nonatomic)  NSString *dateString;
@property (assign, nonatomic)  CGFloat height;

@end
