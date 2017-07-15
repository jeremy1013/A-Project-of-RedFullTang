//
//  HMTSecondHandDetailHeaderView.m
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/13.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandDetailHeaderView.h"
#import "getGoodsDetailReturn.h"
#import "YYWebImage.h"

CGFloat const HMTSecondHandDetailHeaderViewHeigth = 50;

@interface HMTSecondHandDetailHeaderView ()
/** 用户头像*/
@property (nonatomic, strong) UIImageView *imageView;
/** 用户名*/
@property (nonatomic, strong) UILabel *userName;
/** 查看数*/
@property (nonatomic, strong) UILabel *checkNum;


@end


@implementation HMTSecondHandDetailHeaderView

+ (instancetype)header{
    HMTSecondHandDetailHeaderView *view = [[HMTSecondHandDetailHeaderView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [view setUpViews];
    return view;
}

-(void)setFrame:(CGRect)frame{
    CGRect f = frame;
    f.size = CGSizeMake(MainScreenWidth, HMTSecondHandDetailHeaderViewHeigth);
    [super setFrame:f];
}

- (void)setUpViews{
    //用户头像
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    imageView.image = [UIImage imageNamed:@"userDefault"];
    CGFloat imageW = 30;
    CGFloat imageH = 30;
    CGFloat imageX = 10;
    CGFloat imageY = ( HMTSecondHandDetailHeaderViewHeigth - imageH ) / 2;
    imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    imageView.layer.cornerRadius = imageH/2;
    imageView.layer.masksToBounds = YES;
    [self addSubview:imageView];
    
    //查看数
    UILabel *checkNum = [[UILabel alloc] init];
    self.checkNum = checkNum;;
    checkNum.textAlignment = NSTextAlignmentRight;
    CGFloat checkNumW = 100;
    CGFloat checkNumH = HMTSecondHandDetailHeaderViewHeigth;
    CGFloat checkNumX = self.bounds.size.width - checkNumW - 10;
    CGFloat checkNumY = ( HMTSecondHandDetailHeaderViewHeigth - checkNumH ) / 2;
    checkNum.frame = CGRectMake(checkNumX, checkNumY, checkNumW, checkNumH);
    [self addSubview:checkNum];
    
    //用户名
    UILabel *userName = [[UILabel alloc] init];
    self.userName = userName;
    CGFloat userNameW = self.bounds.size.width - CGRectGetMaxX(imageView.frame) - checkNumW - 10 - 10;
    CGFloat userNameH = HMTSecondHandDetailHeaderViewHeigth;
    CGFloat userNameX = CGRectGetMaxX(imageView.frame) + 10;
    CGFloat userNameY = 0;
    userName.frame = CGRectMake(userNameX, userNameY, userNameW, userNameH);
    [self addSubview:userName];
    

}

-(void)setModel:(getGoodsDetailReturn *)model{
    _model = model;
    DetailReturnLinkMan *user = model.secondgoods_linkman;
    
    if (user.members_pic) {
        [self.imageView yy_setImageWithURL:[NSURL URLWithString:user.members_pic] options:YYWebImageOptionProgressive];
    }
    
    self.userName.text = user.members_username;
    
    self.checkNum.text = [NSString stringWithFormat:@"%ld人浏览",(long)model.secondgoods_views.integerValue];
    
    
}

@end
