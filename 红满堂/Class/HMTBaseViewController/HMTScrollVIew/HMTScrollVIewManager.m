//
//  HMTScrollVIewManager.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTScrollVIewManager.h"
#import "HMTScrollVIew.h"
@interface HMTScrollVIewManager ()

@end

@implementation HMTScrollVIewManager

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

+ (instancetype)shareManager{
    static HMTScrollVIewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HMTScrollVIewManager alloc] init];
    });
    return manager;
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
}

@end
