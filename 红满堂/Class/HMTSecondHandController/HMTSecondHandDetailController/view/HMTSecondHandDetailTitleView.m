//
//  HMTSecondHandDetailTitleView.m
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/13.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandDetailTitleView.h"
#import "getGoodsDetailReturn.h"

CGFloat const HMTSecondHandDetailTitleViewHeigth = 100;

@interface HMTSecondHandDetailTitleView ()
/** 内容灰色的view*/
@property (nonatomic, strong) UIView *contentView;
/** 标题*/
@property (nonatomic, strong) UILabel *titleLabel;
/** 价格*/
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation HMTSecondHandDetailTitleView
+ (instancetype)title{
    HMTSecondHandDetailTitleView *title = [[HMTSecondHandDetailTitleView alloc] init];
    title.backgroundColor = [UIColor clearColor];
    [title setUpViews];
    return title;
}

-(void)setFrame:(CGRect)frame{
    CGRect f = frame;
    f.size = CGSizeMake(MainScreenWidth, HMTSecondHandDetailTitleViewHeigth);
    [super setFrame:f];
}

- (void)setUpViews{
    UIView *contentView = [[UIView alloc] init];
    self.contentView = contentView;
    contentView.backgroundColor = rgbColor(222, 222, 222);
    contentView.layer.cornerRadius = 5;
    CGFloat contentW = self.bounds.size.width - 20;
    CGFloat contentH = HMTSecondHandDetailTitleViewHeigth;
    CGFloat contentX = 10;
    CGFloat contentY = 0;
    contentView.frame = CGRectMake(contentX, contentY, contentW, contentH);
    [self addSubview:contentView];
    
    
    //价格
    UILabel *priceLabel = [[UILabel alloc] init];
    self.priceLabel = priceLabel;
    priceLabel.font = [UIFont systemFontOfSize:25.0];
    priceLabel.textColor = rgbColor(251, 0, 6);
    CGFloat priceLabelW = contentW - 20;
    CGFloat priceLabelH = 30;
    CGFloat priceLabelX = 10;
    CGFloat priceLabelY = contentH - priceLabelH;
    priceLabel.frame =  CGRectMake(priceLabelX, priceLabelY, priceLabelW, priceLabelH);
    [contentView addSubview:priceLabel];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.numberOfLines = 0;
    CGFloat labelX = priceLabelX;
    CGFloat labelY = 10;
    CGFloat labelW = contentW - 10;
    CGFloat labelH = HMTSecondHandDetailTitleViewHeigth - 10 - priceLabelH;
    titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    [contentView addSubview:titleLabel];
    
}

-(void)setModel:(getGoodsDetailReturn *)model{
    _model = model;
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.secondgoods_price];
    
    self.titleLabel.text = model.secondgoods_name;
    
    [self.titleLabel sizeToFit];
}

@end
