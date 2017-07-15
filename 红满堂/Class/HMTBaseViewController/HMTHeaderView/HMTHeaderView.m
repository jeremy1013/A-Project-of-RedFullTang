//
//  HMTHeaderView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/21.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTHeaderView.h"
#import "HMTTabbarConfig.h"
#import "UIColor+Extension.h"


//static CGFloat const kMarginY = 20;
//static CGFloat const kViewWh = 44;
static CGFloat const kTabbarHeight = 44;
static CGFloat const kSlideBarHeight = 3;

@interface HMTHeaderView()
/** */
@property (nonatomic, strong) HMTTabbarController *tabbarVc;
/** */
@property (nonatomic, strong) UIView *slideView;



@end

@implementation HMTHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        //设置视图
        [self setUpViews];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    //设置视图
    [self setUpViews];
    
}

-(void)setUpViews{
    
    //导航栏
    HMTTabbarController *tabbarVc = [[HMTTabbarConfig alloc] init].tabbarController;
    self.tabbarVc = tabbarVc;
    UIView *tabbar = tabbarVc.tabbar;
    CGFloat tabbarX = 0;
    CGFloat tabbarY = 0;
    CGFloat tabbarW = MainScreenWidth;
    CGFloat tabbarH = kTabbarHeight;
    tabbar.frame = CGRectMake(tabbarX, tabbarY, tabbarW, tabbarH);
    [self addSubview:tabbar];
    //滑动条
    UIView *slideView = [[UIView alloc] init];
    self.slideView = slideView;
    slideView.backgroundColor = [UIColor whiteColor];
    CGFloat slideViewX = 0;
    CGFloat slideViewH = kSlideBarHeight;
    CGFloat slideViewY = CGRectGetMaxY(tabbar.frame) - slideViewH;
    CGFloat slideViewW = MainScreenWidth / 3;
    
    slideView.frame = CGRectMake(slideViewX, slideViewY, slideViewW, slideViewH);
    [self addSubview:slideView];
    
}

-(void)setOffset:(CGFloat)offset{
    CGRect f = self.slideView.frame;
    f.origin.x = offset / 3;
    self.slideView.frame = f;
    //设置颜色
    
    //251  24  39
    //26    166   214
//    double fenshuR = (26 - 251) / MainScreenWidth;
//    double fenshuG = (166 - 24) / MainScreenWidth;
//    double fenshuB = (214 - 39) / MainScreenWidth;
//    
//    double fen = offset ;
//    
////    HMTLog(@"%f,%f,%f",251 + fenshuR * fen,24 + fenshuG * fen,39 + fenshuB * fen);
//    
//    NSInteger red = 251 + fenshuR * fen;
//    NSInteger green = 24 + fenshuG * fen;
//    NSInteger blue = 39 + fenshuB * fen;
//    
//    if (offset <= MainScreenWidth * 2) {
//        self.tabbarVc.tabbar.backgroundColor = [UIColor colorWithRed:251 + fenshuR * fen green:24 + fenshuG * fen blue:39 + fenshuB * fen alpha:1];
    self.tabbarVc.tabbarColor = [UIColor colorWithOffset:offset];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.backgroundColor = [UIColor colorWithOffset:offset];
//    }
    
}
@end
