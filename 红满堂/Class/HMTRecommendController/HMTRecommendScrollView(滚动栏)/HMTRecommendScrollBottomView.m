//
//  HMTRecommendScrollBottomView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/3.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTRecommendScrollBottomView.h"
#import "HMTRecommendScrollBottomPageView.h"
#import "HMTRecommendScrollBottomViewModel.h"

@implementation HMTRecommendScrollBottomView{
    UILabel *_label;
    HMTRecommendScrollBottomPageView *_pageView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    CGRect f = frame;
    f.size.height = kHMTRecommendScrollBottomViewHeight;
    f.size.width = MainScreenWidth;
    self = [super initWithFrame:f];
    if (self) {
        
    }
    return self;
}

-(void)setModels:(NSArray *)models{
    _models = models;
    //设置视图
    [self setUpViews];
    //显示第一张图片的标题
    self.page = 0;
}

-(void)setPage:(NSInteger)page{
    _page = page;
    HMTRecommendScrollBottomViewModel *model = self.models[page];
    _label.text = model.title;
    _pageView.page = page;
}

- (void)setUpViews{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, kHMTRecommendScrollBottomViewHeight)];
    _label = label;
    [self addSubview:_label];
    
    CGFloat pageW = kHMTRecommendScrollBottomPageViewCellWh * _models.count;
    CGFloat pageH = kHMTRecommendScrollBottomViewHeight;
    CGFloat pageX = MainScreenWidth - pageW;
    CGFloat pageY = 0;
    HMTRecommendScrollBottomPageView *pageView = [[HMTRecommendScrollBottomPageView alloc] initWithFrame:CGRectMake(pageX, pageY,pageW, pageH)];
    _pageView = pageView;
    _pageView.models = _models;
    [self addSubview:_pageView];
}



@end
