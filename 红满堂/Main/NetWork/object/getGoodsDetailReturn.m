//
//  getGoodsDetailReturn.m
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/14.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "getGoodsDetailReturn.h"

@implementation getGoodsDetailReturn
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"secondgoods_picture" : [NSString class]
             };
}

-(void)setSecondgoods_postdate:(NSString *)secondgoods_postdate{
    _secondgoods_postdate = secondgoods_postdate;
    
    if (_secondgoods_goodEffectTime) {
        return;
    }
    
    if (!secondgoods_postdate && !_secondgoods_pastdate) {
        _secondgoods_goodEffectTime = nil;
    }
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:secondgoods_postdate.integerValue];
    NSDateComponents *postCompt = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:postDate];
    
    NSDate *pastDate = [NSDate dateWithTimeIntervalSince1970:_secondgoods_pastdate.integerValue];
    NSDateComponents *pastCompt = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:pastDate];
    
    NSString *str = [NSString stringWithFormat:@"%ld-%ld-%ld~%ld-%ld-%ld",(long)postCompt.year,(long)postCompt.month,(long)postCompt.day,(long)pastCompt.year,(long)pastCompt.month,(long)pastCompt.day];
    
    _secondgoods_goodEffectTime = str;
    
}

-(void)setSecondgoods_pastdate:(NSString *)secondgoods_pastdate{
    _secondgoods_pastdate = secondgoods_pastdate;
    
    if (_secondgoods_goodEffectTime) {
        return;
    }
    if (!secondgoods_pastdate && !_secondgoods_postdate) {
        _secondgoods_goodEffectTime = nil;
    }
}

@end
