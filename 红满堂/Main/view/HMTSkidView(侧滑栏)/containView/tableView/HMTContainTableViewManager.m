//
//  HMTContainTableViewManager.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTContainTableViewManager.h"
#import "HMTContainTableView.h"
#import "HMTContainTableViewModel.h"
#import "HMTContainTableViewCell.h"
#import "HMTUserModel.h"
#import "HMTUserTool.h"
#import "HMTBaseSettingController.h"
#import "HMTTool.h"
#import "HMTSkidView.h"

@interface HMTContainTableViewManager ()
@property (nonatomic, strong, readwrite) HMTContainTableView *HMTTableView;
@property (nonatomic, strong) NSArray *models;
@end

@implementation HMTContainTableViewManager

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewCell) name:KNotificationLogOut object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setTableViewCell) name:KNotificationLogIn object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)shareManager{
    static HMTContainTableViewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HMTContainTableViewManager alloc] init];
    });
    return manager;
}

- (NSArray *)models
{
    HMTUserModel *model = [HMTUserTool model];
    _models = nil;
    if(!_models){
        NSMutableArray *array = [NSMutableArray array];
        
        HMTContainTableViewModel *model0 = [HMTContainTableViewModel modelWithTitle:model?model.groupidName:@"请登录"imageNane:@"0"];
        HMTContainTableViewModel *model1 = [HMTContainTableViewModel modelWithTitle:@"基本设置" imageNane:@"1"];
        HMTContainTableViewModel *model2 = [HMTContainTableViewModel modelWithTitle:@"快速查课" imageNane:@"2"];
        [array addObject:model0];
        [array addObject:model1];
        [array addObject:model2];
        
        self.models = array;
    }
    return _models;
}

- (void)setTableViewCell{
    self.models = nil;
    [self.HMTTableView reloadData];
}


#pragma UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.HMTTableView = (HMTContainTableView *)tableView;
    return self.models.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushViewControllerWithIndex:indexPath.row];
}


#pragma UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HMTContainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kHMTContainTableViewCellIdentifier forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)pushViewControllerWithIndex:(NSInteger)index{
    [HMTSkidView dismiss];
    switch (index) {
        case 0:{
            HMTLog(@"%ld",(long)index);
        }
            break;
        case 1:{
            
            UINavigationController *nav =[HMTTool getPushNavigation];
            
            HMTBaseSettingController *vc = [[HMTBaseSettingController alloc] init];
            [nav pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            HMTLog(@"%ld",(long)index);
        }
            break;
            
        default:
            break;
    }
    
    
}

@end
