//
//  HMTSecondHandSearchBar.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/4.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandSearchBar.h"

static CGFloat const kHMTSecondHandSearchBarH = 44;

@implementation HMTSecondHandSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    CGRect f = frame;
    f.size.height = kHMTSecondHandSearchBarH;
    f.size.width = MainScreenWidth;
    self = [super initWithFrame:f];
    if (self) {
        //设置视图
        [self setUpViews];
    }
    return self;
}
- (void)setUpViews{
    //左边的图片
    UIImageView *leftImageView = [[UIImageView alloc] init];
    leftImageView.frame = CGRectMake(0, 0, kHMTSecondHandSearchBarH, kHMTSecondHandSearchBarH);
    leftImageView.image = [UIImage imageNamed:@"0"];
    [self addSubview:leftImageView];
    //右边的图片
    UIImageView *rightImageView = [[UIImageView alloc] init];
    rightImageView.frame = CGRectMake(CGRectGetMaxX(leftImageView.frame), 0, MainScreenWidth - kHMTSecondHandSearchBarH, kHMTSecondHandSearchBarH);
    rightImageView.image = [UIImage imageNamed:@"1"];
    rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    rightImageView.clipsToBounds = YES;
    [self addSubview:rightImageView];
}
@end
