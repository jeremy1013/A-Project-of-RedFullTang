//
//  getSecondGoodsModel.m
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/11.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "getSecondGoodsModel.h"

@implementation getSecondGoodsModel

-(void)setSecondgoods_postdate:(NSString *)secondgoods_postdate{
    _secondgoods_postdate = secondgoods_postdate;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:secondgoods_postdate.integerValue];
    
    NSTimeInterval timeInterval = -[date timeIntervalSinceNow];
    NSString *str;
    if (timeInterval <= 3600) {
        //一个小时内
        str = [NSString stringWithFormat:@"%d分钟前",(int)(timeInterval / 60)];
    }else if (timeInterval > 3600 && timeInterval < 3600 * 24){
        str = [NSString stringWithFormat:@"%d小时前",(int)(timeInterval / 3600)];
    
    }else if (timeInterval > 3600 * 24){
        str = [NSString stringWithFormat:@"%d天前",(int)(timeInterval / (3600 * 24))];
    }
    
    _secondgoods_postdateString = str;
}

-(void)setMembers_pic:(NSString *)members_pic{
    if (![members_pic isEqualToString:@""]) {
        NSString *str = [NSString stringWithFormat:@"%@%@",@"http://market.scau.edu.cn/Uploads/",members_pic];
        _members_pic = str;
    }else{
        _members_pic = nil;
    }
    
    
}

@end
