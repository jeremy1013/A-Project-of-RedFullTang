//
//  HMTSecondHandController.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/20.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandController.h"
#import "HMTSecondHandSearchBar.h"
#import "HMTSecondHandTableView.h"
#import "NetWorkTool.h"
@interface HMTSecondHandController ()

@end

@implementation HMTSecondHandController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置视图
    [self setUpViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window]) {
        self.view = nil;
    }
}

- (void)setUpViews{
    //搜索栏
    HMTSecondHandSearchBar *searchBar = [[HMTSecondHandSearchBar alloc] initWithFrame:CGRectZero];
    [self.view addSubview:searchBar];
    
    //tableview
    HMTSecondHandTableView *tableView = [[HMTSecondHandTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(searchBar.frame), MainScreenWidth, MainScreenHeight - CGRectGetMaxY(searchBar.frame) -44) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    //获取二手的数据
    getSecondGoodsParam *param = [[getSecondGoodsParam alloc] init];
    param.page = @"1";
    param.limit = @"20";
    [NetWorkTool getSecondGoodsWithParams:param Success:^(getSecondGoodsReturn *result) {
        tableView.models = result.goods;
        [tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    
#warning TODO 上拉加载

}


@end
