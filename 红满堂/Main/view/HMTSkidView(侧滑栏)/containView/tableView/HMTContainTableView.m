//
//  HMTContainTableView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTContainTableView.h"
#import "HMTContainTableViewManager.h"

@implementation HMTContainTableView{
    HMTContainTableViewManager *_manager;

}
//-(id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        //设置视图
//        [self setUpTableView];
//    }
//    return self;
//}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //设置视图
        [self setUpTableView];
    }
    return self;
}

- (void)setUpTableView{
    _manager = [HMTContainTableViewManager shareManager];
    self.delegate = _manager;
    self.dataSource = _manager;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.scrollEnabled = NO;
    self.backgroundColor = rgbColor(249, 249, 249);
    [self registerNib:[UINib nibWithNibName:@"HMTContainTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHMTContainTableViewCellIdentifier];
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setView) name:KNotificationLogOut object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setView) name:KNotificationLogIn object:nil];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setView{
    
    [self reloadData];
}


@end
