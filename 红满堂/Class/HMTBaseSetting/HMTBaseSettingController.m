//
//  HMTBaseSettingController.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/1.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTBaseSettingController.h"
#import "HMTBaseSettingControllerTableView.h"

@interface HMTBaseSettingController ()
@property (weak, nonatomic) IBOutlet HMTBaseSettingControllerTableView *tableView;
- (IBAction)logoutBtn:(id)sender;

@end

@implementation HMTBaseSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logoutBtn:(id)sender {
}
@end
