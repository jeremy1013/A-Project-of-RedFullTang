//
//  HMTSecondHandDeviceTableViewController.m
//  红满堂
//
//  Created by Yuexi on 16/11/20.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandDeviceTableViewController.h"
#import "HMTSecondHandDeviceTableViewCell.h"
#import "NetWorkTool.h"
#import "HMTSecondHandDeviceModel.h"
#import "getSecondGoodsModel.h"
#import "HMTSecondHandDetailController.h"
#import "HMTTool.h"
@interface HMTSecondHandDeviceTableViewController ()
@property (strong, nonatomic)  NSArray *arr;
@end

@implementation HMTSecondHandDeviceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgbColor(248, 248, 248);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HMTSecondHandDeviceTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HMTSecondHandDeviceTableViewCell"];
    
    [self getModel];
    
    UIRefreshControl *refrsh = [[UIRefreshControl alloc]init];
    refrsh.attributedTitle = [[NSAttributedString alloc]initWithString:@"哥在玩命加载呢..."];
    [refrsh addTarget:self action:@selector(getModel) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refrsh;
    [self.refreshControl beginRefreshing];
    
}

-(void)setArr:(NSArray *)arr{
    _arr = arr;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

-(void)getModel{
    getSecondHandClassifyGoodsParam *param = [[getSecondHandClassifyGoodsParam alloc] init];
    param.page = @"1";
    param.limit = @"20";
            if (self.tagNum == 0) {
                param.channel = @"8";
            }else if (self.tagNum == 1){
                param.channel = @"12";
            }else if (self.tagNum == 2){
                param.channel = @"14";
            }else if (self.tagNum == 3){
                param.channel = @"15";
            }else if (self.tagNum == 4){
                param.channel = @"13";
            }else if (self.tagNum == 5){
                param.channel = @"16";
            }else if (self.tagNum == 6){
                param.channel = @"18";
            }
    [NetWorkTool getSecondHandClassifyGoodsWithParams:param Success:^(getSecondGoodsReturn *result) {
        self.arr = result.goods;
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cell_id = @"HMTSecondHandDeviceTableViewCell";
    HMTSecondHandDeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id forIndexPath:indexPath];
    getSecondGoodsModel *model = self.arr[indexPath.row];
    cell.model = model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self pushViewControllerWithIndex:indexPath.row model:self.arr[indexPath.row]];
}

- (void)pushViewControllerWithIndex:(NSInteger)index model:(getSecondGoodsModel *)model{
    HMTSecondHandDetailController *vc = [[HMTSecondHandDetailController alloc] init];
    vc.goodID = model.secondgoods_id;
    UINavigationController *nav =[HMTTool getPushNavigation];
    [nav pushViewController:vc animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
