//
//  HMTSecondHandTableView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/18.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandTableView.h"
#import "HMTSecondHandTableViewHeaderView.h"

@implementation HMTSecondHandTableView{
    HMTSecondHandTableViewManager *_manager;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //设置视图
        [self setUpTableView];
    }
    return self;
}

- (void)setUpTableView{
    _manager = [HMTSecondHandTableViewManager shareManager];
    self.delegate = _manager;
    self.dataSource = _manager;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = rgbColor(248, 248, 248);
    
    [self registerNib:[UINib nibWithNibName:@"HMTSecondHandTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHMTSecondHandTableViewCellIdentifier];
    
    //headerView
    HMTSecondHandTableViewHeaderView *headerView = [[HMTSecondHandTableViewHeaderView alloc] initWithFrame:CGRectZero];
    self.tableHeaderView = headerView;
}

-(void)setModels:(NSArray *)models{
    _models = models;
    _manager.models = models;
}

@end
