//
//  HMTClassifyControllerDifferentViewModel.m
//  红满堂
//
//  Created by Yuexi on 16/11/7.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTClassifyControllerDifferentViewModel.h"

@implementation HMTClassifyControllerDifferentViewModel

+(instancetype)modelWithDic:(NSDictionary *)dic{
    HMTClassifyControllerDifferentViewModel *model = [self new];
    
    
    model.author = [dic valueForKey:@"author"];
    model.subject = [dic valueForKey:@"subject"];
    model.message = [dic valueForKey:@"message"];
    model.replies = [dic valueForKey:@"replies"];
    model.dateline = [dic valueForKey:@"dateline"];
    
    return model;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
