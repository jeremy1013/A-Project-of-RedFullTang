//
//  HMTScrollVIew.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTScrollVIew.h"
#import "HMTScrollVIewManager.h"
#import "HMTSecondHandController.h"
#import "HMTClassifyController.h"
#import "HMT-Swift.h"

@interface HMTScrollVIew ()
@property (nonatomic, strong) HMTSecondHandController *secondHandVC;
@property (nonatomic, strong) HMTClassifyController *classifyVC;
@property (nonatomic, strong) HMTRecommendViewController *recommendVC;
@end

@implementation HMTScrollVIew

-(void)awakeFromNib{
    [super awakeFromNib];
    
    //设置视图
    [self setUpViews];
}


- (void)setUpViews{
    HMTScrollVIewManager *manager = [HMTScrollVIewManager shareManager];
    manager.scrollView = self;
    
    self.delegate = manager;
    self.scrollEnabled = YES;
    self.bounces = NO;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.contentSize = CGSizeMake(MainScreenWidth * 3, 0);
//    [self setContentOffset:CGPointMake(MainScreenWidth, 0)];
    
//    [self addSecondHandVC];
    
//    [self addRecommendVC];
    
    // [self addClassifyVC];
    
}

- (void)addSecondHandVC{
    if (!self.secondHandVC) {
        self.secondHandVC = [[HMTSecondHandController alloc] init];
    }
    UIView *secondHandVCcontain = self.secondHandVC.view;
    secondHandVCcontain.tag = 0;
    secondHandVCcontain.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:secondHandVCcontain];
    
    
}

- (void)addRecommendVC{
    if (!self.recommendVC) {
        self.recommendVC = [[HMTRecommendViewController alloc] init];
    }
    UIView *recommendVCcontain = self.recommendVC.view;
    recommendVCcontain.tag = 1;
    recommendVCcontain.frame = CGRectMake(MainScreenWidth, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview: recommendVCcontain];
    [_recommendVC viewDidAppear:true];
    
}

- (void)addClassifyVC{
    if (!self.classifyVC) {
        self.classifyVC = [[HMTClassifyController alloc] init];
    }
    UIView *classifyVCcontain = self.classifyVC.view;
    classifyVCcontain.tag = 2;
    classifyVCcontain.frame = CGRectMake(MainScreenWidth * 2, 0, self.bounds.size.width, self.bounds.size.height);
    [self addSubview:classifyVCcontain];
    
}

- (void)removeSecondHandVC{
    //self.secondHandVC = nil;
    for (UIView *subview in [self subviews]) {
        if (subview.tag == 0) {
            [subview removeFromSuperview];
        }
    }
}

- (void)removeRecommendVC{
    //self.recommendVC = nil;
    for (UIView *subview in [self subviews]) {
        if (subview.tag == 1) {
            [subview removeFromSuperview];
        }
    }
}

- (void)removeClassifyVC{
    //self.classifyVC = nil;
    for (UIView *subview in [self subviews]) {
        if (subview.tag == 2) {
            [subview removeFromSuperview];
        }
    }
}

@end
