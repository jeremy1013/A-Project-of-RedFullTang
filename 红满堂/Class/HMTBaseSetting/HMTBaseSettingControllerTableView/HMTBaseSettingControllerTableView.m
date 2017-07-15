//
//  HMTBaseSettingControllerTableView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/1.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTBaseSettingControllerTableView.h"
#import "HMTBaseSettingControllerTableViewManager.h"

@implementation HMTBaseSettingControllerTableView{
    HMTBaseSettingControllerTableViewManager *_manager;
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //设置视图
    [self setUpTableView];
}

- (void)setUpTableView{
    _manager = [HMTBaseSettingControllerTableViewManager shareManager];
    self.delegate = _manager;
    self.dataSource = _manager;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.scrollEnabled = NO;
    [self registerNib:[UINib nibWithNibName:@"HMTBaseSettingTableViewCellIsShowImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHMTBaseSettingTableViewCellIsShowImageIdentifier];
    [self registerNib:[UINib nibWithNibName:@"HMTBaseSettingTableViewCellCheckUpdateCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kHMTBaseSettingTableViewCellCheckUpdateIdentifier];
}

@end
