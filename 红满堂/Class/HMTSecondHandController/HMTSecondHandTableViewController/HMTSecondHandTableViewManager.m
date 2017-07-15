//
//  HMTSecondHandTableViewManager.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/18.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandTableViewManager.h"
#import "HMTSecondHandTableView.h"
#import "HMTSecondHandTableViewModel.h"
#import "HMTTool.h"
#import "HMTSecondHandTableViewCell.h"
#import "HMTSecondHandDetailController.h"
#import "getSecondGoodsModel.h"

@interface HMTSecondHandTableViewManager ()
@property (nonatomic, strong, readwrite) HMTSecondHandTableView *HMTTableView;
//@property (nonatomic, strong) NSArray *models;
@property (nonatomic, assign) CGFloat offset;
@end

@implementation HMTSecondHandTableViewManager

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
    static HMTSecondHandTableViewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HMTSecondHandTableViewManager alloc] init];
    });
    return manager;
}


#pragma UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.HMTTableView = (HMTSecondHandTableView *)tableView;
    return self.models.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self pushViewControllerWithIndex:indexPath.row model:self.models[indexPath.row]];
}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    CGFloat offset = scrollView.contentOffset.y;
////    self.HMTTableView.tableHeaderView.frame = CGRectMake(0, offset*2, MainScreenWidth, 200);
//    CGFloat maxOffset =  scrollView.contentSize.height - self.HMTTableView.frame.size.height;
//    UINavigationController *nav = [HMTTool getPushNavigation];
//    UIViewController *view = nav.topViewController;
//    if (offset >= 60 && view.navigationController.isNavigationBarHidden == NO) {
//        //[view.navigationController setNavigationBarHidden:YES animated:YES];
//        [HMTTool setBaseNavigationBarHidden:YES animated:YES];
//    }
//    if(offset <= self.offset && offset < maxOffset && view.navigationController.isNavigationBarHidden){//往上滑
//        //[view.navigationController setNavigationBarHidden:NO animated:YES];
//        [HMTTool setBaseNavigationBarHidden:NO animated:YES];
//    }
//    self.offset = offset;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

#pragma UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HMTSecondHandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHMTSecondHandTableViewCellIdentifier forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)pushViewControllerWithIndex:(NSInteger)index model:(getSecondGoodsModel *)model{
    HMTSecondHandDetailController *vc = [[HMTSecondHandDetailController alloc] init];
    vc.goodID = model.secondgoods_id;
    UINavigationController *nav =[HMTTool getPushNavigation];
    [nav pushViewController:vc animated:YES];
    
}

@end
