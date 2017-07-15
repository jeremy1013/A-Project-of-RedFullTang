//
//  HMTSecondHandDetailController.m
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/13.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandDetailController.h"
#import "HMTTool.h"
#import "HMTSecondHandDetailScrollView.h"
#import "NetWorkTool.h"

@interface HMTSecondHandDetailController ()
@property (weak, nonatomic) IBOutlet HMTSecondHandDetailScrollView *scrollView;


@end

@implementation HMTSecondHandDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //设置导航栏
    [self setUpNav];
    //设置视图
    [self setUpViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpViews{
    
    if (self.goodID) {
        
        getGoodsDetailParam *param = [[getGoodsDetailParam alloc] init];
        param.goodID = self.goodID;
        WeakSelf;
        [NetWorkTool getGoodsDetailWithParams:param Success:^(getGoodsDetailReturn *result) {
            if (result) {
                weakSelf.scrollView.model = result;
                
            }
        } failure:^(NSError *error) {
            
        }];
    }
    
   
    
}

-(void)setUpNav{
    UINavigationController *nav = [HMTTool getPushNavigation];
    UIViewController *view = nav.topViewController;
    [view.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
