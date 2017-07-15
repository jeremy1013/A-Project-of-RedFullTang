//
//  HMTClassifyControllerDifferentViewModel.h
//  红满堂
//
//  Created by Yuexi on 16/11/7.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTClassifyControllerDifferentViewModel : NSObject

@property (strong, nonatomic)  NSString *tid;
@property (strong, nonatomic)  NSString *author;
@property (strong, nonatomic)  NSString *authorid;
@property (strong, nonatomic)  NSString *subject;
@property (strong, nonatomic)  NSString *replies;
@property (strong, nonatomic)  NSString *lastpost;
@property (strong, nonatomic)  NSString *lastposter;
@property (strong, nonatomic)  NSString *views;
@property (strong, nonatomic)  NSString *message;
@property (strong, nonatomic)  NSString *dateline;
+(instancetype)modelWithDic:(NSDictionary *)dic;

@end
