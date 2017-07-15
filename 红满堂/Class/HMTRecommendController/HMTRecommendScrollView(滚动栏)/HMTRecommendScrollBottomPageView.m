//
//  HMTRecommendScrollBottomPageView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/3.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTRecommendScrollBottomPageView.h"

static CGFloat const kViewWh = 12;

@implementation HMTRecommendScrollBottomPageView{
    NSMutableArray *_array;
}

-(void)setModels:(NSArray *)models{
    _models = models;
    
    //设置视图
    [self setUpViews];
}


- (void)setUpViews{
    _array = [NSMutableArray array];
    CGFloat viewY = self.frame.size.height / 2 - kViewWh / 2;
    CGFloat viewW = kViewWh;
    CGFloat viewH = kViewWh;
    
    CGFloat margin = kHMTRecommendScrollBottomPageViewCellWh / 2 - kViewWh / 2;
    
    for (int i = 0; i<_models.count; i++) {
        CGFloat viewX = kHMTRecommendScrollBottomPageViewCellWh * i + margin;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
        view.backgroundColor = [UIColor redColor];
        view.layer.cornerRadius = viewW / 2;
        view.layer.masksToBounds = YES;
        view.layer.shouldRasterize = YES;
        view.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [_array addObject:view];
        [self addSubview:view];
    }
    
}

-(void)setPage:(NSInteger)page{
    for (int i = 0; i<_array.count; i++) {
        UIView *view = _array[i];
        if (i == page) {
            view.backgroundColor = [UIColor whiteColor];
        }else{
            view.backgroundColor = [UIColor redColor];
        }
        
    }
    
}

@end
