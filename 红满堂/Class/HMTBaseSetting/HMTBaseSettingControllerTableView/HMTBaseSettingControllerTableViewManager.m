//
//  HMTBaseSettingControllerTableViewManager.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/1.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTBaseSettingControllerTableViewManager.h"
#import "HMTBaseSettingControllerTableView.h"
#import "HMTBaseSettingTableViewCellCheckUpdateCell.h"
#import "HMTBaseSettingTableViewCellIsShowImageCell.h"

@interface HMTBaseSettingControllerTableViewManager ()
@property (nonatomic, strong, readwrite) HMTBaseSettingControllerTableView *HMTTableView;
@end

@implementation HMTBaseSettingControllerTableViewManager

+ (instancetype)shareManager{
    static HMTBaseSettingControllerTableViewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HMTBaseSettingControllerTableViewManager alloc] init];
    });
    return manager;
}


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


#pragma UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.HMTTableView = (HMTBaseSettingControllerTableView *)tableView;
    return 2;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushViewControllerWithIndex:indexPath.row];
}


#pragma UITableViewDataSource
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            HMTBaseSettingTableViewCellIsShowImageCell *cell = [tableView dequeueReusableCellWithIdentifier:kHMTBaseSettingTableViewCellIsShowImageIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
        case 1:{
            HMTBaseSettingTableViewCellCheckUpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:kHMTBaseSettingTableViewCellCheckUpdateIdentifier forIndexPath:indexPath];
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)pushViewControllerWithIndex:(NSInteger)index{
    HMTLog(@"%ld",(long)index);
    
}

@end
