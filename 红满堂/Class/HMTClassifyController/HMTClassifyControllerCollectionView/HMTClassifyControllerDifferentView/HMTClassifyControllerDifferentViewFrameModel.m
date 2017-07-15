//
//  HMTClassifyControllerDifferentViewFrameModel.m
//  红满堂
//
//  Created by Yuexi on 16/11/8.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTClassifyControllerDifferentViewFrameModel.h"
#import "HMTClassifyControllerDifferentViewModel.h"

@implementation HMTClassifyControllerDifferentViewFrameModel

-(void)setModel:(HMTClassifyControllerDifferentViewModel *)model{
    _model = model;
    
    _imaView = @"0";
    _tid = model.tid;
    _name = model.author;
    _tittle = model.subject;
    _text = model.message;
    _reply = model.replies;
    self.date = model.dateline;
    CGSize size = [model.subject boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 22, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    _height = size.height+7+40+46+17+4+23;
    
}

-(void)setDate:(NSString *)date{
    _date = date;
    NSDate *da = [NSDate dateWithTimeIntervalSince1970:date.integerValue];
    
    NSTimeInterval timeInterval = -[da timeIntervalSinceNow];
    NSString *str;
    if (timeInterval <= 3600) {
        //一个小时内
        str = [NSString stringWithFormat:@"%d分钟前",(int)(timeInterval / 60)];
    }else if (timeInterval > 3600 && timeInterval < 3600 * 24){
        str = [NSString stringWithFormat:@"%d小时前",(int)(timeInterval / 3600)];
        
    }else if (timeInterval > 3600 * 24){
        str = [NSString stringWithFormat:@"%d天前",(int)(timeInterval / (3600 * 24))];
    }
    _dateString = str;
    HMTLog(@"%@",_dateString);
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
