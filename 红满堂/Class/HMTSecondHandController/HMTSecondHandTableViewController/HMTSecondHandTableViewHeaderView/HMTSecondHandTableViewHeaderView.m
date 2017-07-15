//
//  HMTSecondHandTableViewHeaderView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/30.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandTableViewHeaderView.h"
#import "HMTRecommendScrollView.h"
#import "HMTSecondHandTableViewHeaderSelectView.h"

#import "HMTRecommendScrollBottomViewModel.h"

@implementation HMTSecondHandTableViewHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    CGRect f = frame;
    f.size.height = kHMTRecommendScrollViewHeight + kHMTSecondHandTableViewHeaderSelectViewHeight;
    f.size.width = MainScreenWidth;
    self = [super initWithFrame:f];
    if (self) {
       //设置视图
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    HMTRecommendScrollView *scrollView = [[HMTRecommendScrollView alloc] initWithFrame:CGRectZero];
    NSMutableArray *array = [NSMutableArray array];
       for (int i = 0; i<3; i++) {
        HMTRecommendScrollBottomViewModel *model = [[HMTRecommendScrollBottomViewModel alloc] init];
        model.title = [NSString stringWithFormat:@"第%d张图的标题",i];
        [array addObject:model];
    }
    scrollView.imageArr = array;
    
    [self addSubview:scrollView];
    
    HMTSecondHandTableViewHeaderSelectView *selectView = [[HMTSecondHandTableViewHeaderSelectView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(scrollView.frame), 0, 0)];
    [self addSubview:selectView];
}

@end
