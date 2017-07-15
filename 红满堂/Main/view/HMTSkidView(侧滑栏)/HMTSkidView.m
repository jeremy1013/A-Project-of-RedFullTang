//
//  HMTSkidView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/21.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSkidView.h"
#import "HMTSkidContainView.h"


@interface HMTSkidView()
@property (nonatomic, strong) UIVisualEffectView *blurView;
@property (nonatomic, strong) HMTSkidContainView *containView;
@end


@implementation HMTSkidView

+ (instancetype)shareSkidView{
    static HMTSkidView *skidView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        skidView = [[HMTSkidView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    });
    return skidView;
}

+(void)show{
    HMTSkidView *skidView = [HMTSkidView shareSkidView];
    [skidView show];
}

+ (void)dismiss{
    HMTSkidView *skidView = [HMTSkidView shareSkidView];
    [skidView removeFromSuperview];
}

-(void)show{
    self.containView.transform = CGAffineTransformMakeTranslation(-MainScreenWidth / 1.5, 0);
    [UIView animateWithDuration:0.25 animations:^{
        self.containView.transform = CGAffineTransformIdentity;
        self.blurView.alpha = 0.7;
    }];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置视图
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    UIVisualEffectView *blur = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.blurView = blur;
    blur.frame = self.bounds;
    blur.alpha = 0;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundClick)];
    [blur addGestureRecognizer:tapGes];
    [self addSubview:blur];
    
    HMTSkidContainView *containView = [[HMTSkidContainView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth / 1.5, MainScreenHeight)];
    self.containView = containView;
    [self addSubview:containView];
}

- (void)backgroundClick{
    [UIView animateWithDuration:0.15 animations:^{
        self.containView .transform = CGAffineTransformMakeTranslation(-MainScreenWidth / 1.5, 0);
        self.blurView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

@end
