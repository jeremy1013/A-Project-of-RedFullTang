//
//  HMTSkidContainView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/26.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSkidContainView.h"
#import "HMTSkidContainViewHeader.h"
#import "HMTContainTableView.h"

@implementation HMTSkidContainView

- (instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        //设置视图
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    HMTSkidContainViewHeader *header = [[HMTSkidContainViewHeader alloc] initWithFrame:CGRectZero];
    [self addSubview:header];
    HMTContainTableView *tableView = [[HMTContainTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(header.frame), header.bounds.size.width, MainScreenHeight - header.bounds.size.height) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor whiteColor];
    [self addSubview:tableView];
}

@end
