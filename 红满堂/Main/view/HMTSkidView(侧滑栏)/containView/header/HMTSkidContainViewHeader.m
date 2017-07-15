//
//  HMTSkidContainViewHeader.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/26.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSkidContainViewHeader.h"
#import "OYQOauth2Controller.h"
#import "HMTTabbarConfig.h"
#import "HMTTool.h"
#import "HMTSkidView.h"
#import "HMTUserModel.h"
#import "HMTUserTool.h"
#import "HMTTokenTool.h"
#import "HMTHeaderLabel.h"
#import "YYWebImage.h"

CGFloat const kIconImageViewWidthHeight = 100;
CGFloat const kHMTHeaderLabelHeight = 50;
CGFloat const kHMTHeaderLabelWidth = 200;


@implementation HMTSkidContainViewHeader{
    UILabel *_nameLabel;
    UIImageView *_imageview;
}

-(id)initWithFrame:(CGRect)frame
{
    CGRect f = CGRectMake(0, 0, MainScreenWidth / 1.5, 200);
    self = [super initWithFrame:f];
    if (self) {
        //设置视图
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    self.backgroundColor = [UIColor redColor];
//    头像
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageview = imageView;
    imageView.frame = CGRectMake(20, 20, kIconImageViewWidthHeight, kIconImageViewWidthHeight);
    imageView.image = [UIImage imageNamed:@"userDefault"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.layer.cornerRadius = kIconImageViewWidthHeight / 2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.shouldRasterize = YES;
    imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconClick)];
    [imageView addGestureRecognizer:tap];
    [self addSubview:imageView];
    
    //名字
    UILabel *label = [[UILabel alloc] init];
    _nameLabel = label;
    [self setLabelText];
    label.textAlignment = NSTextAlignmentCenter;
    CGFloat labelX = 20;
    CGFloat labelY = CGRectGetMaxY(imageView.frame);
    CGFloat labelW = kIconImageViewWidthHeight;
    CGFloat labelH = 25;
    label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    [self addSubview:label];
    
    //注销按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(logoutBtn) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"注销测试" forState:UIControlStateNormal];
    button.frame = CGRectMake(150, 50, 100, 50);
    [self addSubview:button];
    
    //headerlabel
    CGFloat headerX = MainScreenWidth / 1.5 - 200;;
    CGFloat headerY = 200 - 50;
    HMTHeaderLabel *headerLabel = [[HMTHeaderLabel alloc] initWithFrame:CGRectMake(headerX, headerY, kHMTHeaderLabelWidth, kHMTHeaderLabelHeight)];
    [self addSubview:headerLabel];
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLabelText) name:KNotificationLogOut object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setLabelText) name:KNotificationLogIn object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)iconClick{
    if (![HMTTokenTool isDownload]) {
        [HMTSkidView dismiss];
        UINavigationController *nav =[HMTTool getPushNavigation];
        OYQOauth2Controller *oauth2 = [[OYQOauth2Controller alloc] init];
        [nav pushViewController:oauth2 animated:YES];
    }
    
}

- (void)logoutBtn{
    [HMTTokenTool loginOut];
}

- (void)setLabelText{
    HMTUserModel *model = [HMTUserTool model];
    _nameLabel.text = model? model.username : @"点击登录";
    
    if (model) {
        //异步加载头像
        YYImageCache *cache = [YYWebImageManager sharedManager].cache;
        // 清空缓存
        [cache.memoryCache removeAllObjects];
        [cache.diskCache removeAllObjects];
//        _imageview.yy_imageURL = [NSURL URLWithString:model.avatar];
        
        [_imageview yy_setImageWithURL:[NSURL URLWithString:model.avatar] options:YYWebImageOptionProgressive];
    }else{
        _imageview.image = [UIImage imageNamed:@"userDefault"];
    }
    
    
}

@end
