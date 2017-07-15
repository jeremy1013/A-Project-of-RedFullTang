//
//  HMTSecondHandTableViewModel.h
//  红满堂
//
//  Created by 欧阳铨 on 16/9/18.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTSecondHandTableViewModel : NSObject
///照片链接
@property (nonatomic, copy) NSString *imageUrl;
///头像链接
@property (nonatomic, copy) NSString *iconUrl;
///发布时间
@property (nonatomic, assign) NSInteger timeStamp;
///发布时间
@property (nonatomic, copy) NSString *issueDate;
///标题
@property (nonatomic, copy) NSString *title;
///价格
@property (nonatomic, assign) NSInteger price;
///查看数
@property (nonatomic, assign) NSInteger checkCount;
@end
