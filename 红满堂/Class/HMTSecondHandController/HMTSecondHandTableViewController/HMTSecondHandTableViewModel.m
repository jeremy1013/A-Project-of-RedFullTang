//
//  HMTSecondHandTableViewModel.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/18.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandTableViewModel.h"

@implementation HMTSecondHandTableViewModel
-(void)setTimeStamp:(NSInteger)timeStamp{
    _timeStamp = timeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:timeStamp];
    NSTimeInterval timeInterval = [date timeIntervalSinceDate:[NSDate date]];
    NSString *str = [NSString stringWithFormat:@"发表于%d小时前",(int)(timeInterval / 3600)];
    _issueDate = str;
}
@end
