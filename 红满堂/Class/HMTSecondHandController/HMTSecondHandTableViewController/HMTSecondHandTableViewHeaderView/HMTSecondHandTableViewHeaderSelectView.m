//
//  HMTSecondHandTableViewHeaderSelectView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/30.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandTableViewHeaderSelectView.h"
#import "HMTSecondHandButton.h"
#import "HMTSecondHandDeviceTableViewController.h"
#import "HMTTool.h"
#import "HMTSecondHandTableView.h"
#import "HMTSecondHandTableViewManager.h"
#define Margin (( MainScreenWidth -  3 * viewW ) / 4)
static CGFloat const viewW = 80;
static CGFloat const viewH = kHMTSecondHandTableViewHeaderSelectViewHeight ;

@interface HMTSecondHandTableViewHeaderSelectView ()

@property(nonatomic,strong) UIScrollView *scrView;

@end

@implementation HMTSecondHandTableViewHeaderSelectView

-(instancetype)initWithFrame:(CGRect)frame
{
    CGRect f = frame;
    f.size.height = kHMTSecondHandTableViewHeaderSelectViewHeight;
    f.size.width = MainScreenWidth;
    self = [super initWithFrame:f];
    if (self) {
        //设置视图
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    //创建scrollView
    self.scrView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, viewH)];
    self.scrView.backgroundColor = [UIColor clearColor];
    self.scrView.contentSize = CGSizeMake(viewW * 7 + Margin * 8, 0);
    self.scrView.bounces = NO;
    [self addSubview:self.scrView];

    //把六个selectView加到scrollView上面
    for (int i = 0; i<7; i++) {
        [self setImageViewViewIndex:i];
    }
}

- (void)setImageViewViewIndex:(NSInteger)index{
    
    CGFloat viewX = Margin + ( Margin + viewW ) *index;
    CGFloat viewY = 0;
    //自己创建的button类，使按钮图片在上文字在下
    HMTSecondHandButton *btn = [HMTSecondHandButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(viewX, viewY, viewW, viewH);
    btn.tag = index;
    [btn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [btn setTitle:[self getLabelTextWithIndex:index] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //btn.titleLabel.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrView addSubview:btn];
    
}

-(void)btnClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    [HMTTool setBaseNavigationBarHidden:NO animated:YES];
    HMTSecondHandDeviceTableViewController *controller = [[HMTSecondHandDeviceTableViewController alloc]init];
    controller.tagNum = (int) btn.tag;
    UINavigationController *nav = [HMTTool getPushNavigation];
    [nav pushViewController:controller animated:YES];
    
    
}


- (NSString *)getLabelTextWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            return @"数码类";
            break;
        case 1:
            return @"招聘兼职";
            break;
        case 2:
            return @"日常用品";
            break;
        case 3:
            return @"单车特卖区";
            break;
        case 4:
            return @"房屋招聘";
            break;
        case 5:
            return @"书摊";
            break;
        case 6:
            return @"其他";
            break;
            
        default:
            return @"未知";
            break;
    };
}

@end
