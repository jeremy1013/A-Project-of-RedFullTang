//
//  HMTSkidViewButton.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/21.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSkidViewButton.h"
#import "HMTSkidView.h"


CGFloat const kButtonWH = 44;

@implementation HMTSkidViewButton

-(void)setFrame:(CGRect)frame{
    frame.size.width = kButtonWH;
    frame.size.height = kButtonWH;
    [super setFrame:frame];
}

+ (instancetype)button{
    HMTSkidViewButton *button = [HMTSkidViewButton buttonWithType:UIButtonTypeCustom];
    [button setUp];
    return button;
}

- (void)setUp{
    [self setTitle:@"test" forState:UIControlStateNormal];
    [self addTarget:self action:@selector(showSkidView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showSkidView{
    [HMTSkidView show];
}

@end
