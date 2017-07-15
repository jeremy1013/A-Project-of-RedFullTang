//
//  HMTSecondHandDetailScrollView.m
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/13.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandDetailScrollView.h"
#import "HMTSecondHandDetailHeaderView.h"
#import "HMTSecondHandDetailTitleView.h"
#import "HMTSecondHandDetailDetailView.h"
#import "HMTSecondHandDetailContentView.h"
#import "getGoodsDetailReturn.h"

@interface HMTSecondHandDetailScrollView()
@property (nonatomic, strong) HMTSecondHandDetailHeaderView *heder;
@property (nonatomic, strong) HMTSecondHandDetailTitleView *title;
@property (nonatomic, strong) HMTSecondHandDetailDetailView *detail;
@property (nonatomic, strong) HMTSecondHandDetailContentView *content;

@end

@implementation HMTSecondHandDetailScrollView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    //设置视图
    [self setUpViews];
}


- (void)setUpViews{
    self.scrollEnabled = YES;
    self.bounces = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.contentSize = CGSizeMake(MainScreenWidth, 350);
    
    HMTSecondHandDetailHeaderView *header = [HMTSecondHandDetailHeaderView header];
    self.heder = header;
    header.frame = CGRectMake(0, 0, 0, 0);
    [self addSubview:header];
    
    HMTSecondHandDetailTitleView *title = [HMTSecondHandDetailTitleView title];
    self.title = title;
    title.frame = CGRectMake(0, 60, 0, 0);
    [self addSubview:title];
    
    HMTSecondHandDetailDetailView *detail = [HMTSecondHandDetailDetailView detail];
    self.detail = detail;
    detail.frame = CGRectMake(0, 170, 0, 0);
    [self addSubview:detail];
    
    HMTSecondHandDetailContentView *content = [[HMTSecondHandDetailContentView alloc] init];
    self.content = content;
    content.frame = CGRectMake(0, 350, 0, 0);
    [self addSubview:content];
}

-(void)setModel:(getGoodsDetailReturn *)model{
    _model = model;
    
    self.heder.model = model;
    self.title.model = model;
    self.detail.model = model;
    self.content.model = model;
    self.content.scrollView = self;
}
@end
