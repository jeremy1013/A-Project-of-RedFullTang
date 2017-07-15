//
//  HMTClassifyControllerDifferentViewTableViewController.m
//  红满堂
//
//  Created by Yuexi on 16/11/7.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTClassifyControllerDifferentViewTableViewController.h"
#import "HMTClassifyControllerDifferentViewTableViewCell.h"
#import "HMTClassifyControllerDifferentViewModel.h"
#import "HMTClassifyControllerDifferentViewFrameModel.h"
#import "getClassifyViewParam.h"
#import "NetWorkTool.h"
#import "HMT-Swift.h"
#import "HMTClassifyDetialTableViewController.h"
#import "HMTTool.h"

@interface HMTClassifyControllerDifferentViewTableViewController ()


@property (strong, nonatomic)  NSArray *modelArr;




@end

@implementation HMTClassifyControllerDifferentViewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgbColor(248, 248, 248);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HMTClassifyControllerDifferentViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"DifferentViewTableViewCell"];
    
    
    [self loadData];
    
    UIRefreshControl *refrsh = [[UIRefreshControl alloc]init];
    refrsh.attributedTitle = [[NSAttributedString alloc]initWithString:@"哥在玩命加载呢..."];
    [refrsh addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refrsh;
    [self.refreshControl beginRefreshing];
   
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setModelArr:(NSArray *)modelArr{
    _modelArr = modelArr;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}


-(void)loadData{
    
    getClassifyViewParam *param = [[getClassifyViewParam alloc]init];
    param.fid = self.clickChannel;
    param.page = @"1";
    param.limit = @"30";
    [NetWorkTool getClassifyViewWithParams:param Success:^(getClassifyViewModelReturn *result) {
//        NSArray *arr = [[NSArray alloc]init];
//        arr = result.threads;
        NSMutableArray *mutArr = [NSMutableArray array];
        for (HMTClassifyControllerDifferentViewModel *model in result.threads) {
            HMTClassifyControllerDifferentViewFrameModel *frameModel = [[HMTClassifyControllerDifferentViewFrameModel alloc]init];
            frameModel.model = model;
            NSLog(@"%f",frameModel.height);
            [mutArr addObject:frameModel];
        }
//        //NSLog(@"%@",mutArr);
//        _modelArr = mutArr;
//        NSLog(@"%lu",(unsigned long)_modelArr.count);
//        [self.tableView reloadData];
        NSArray *arr = [mutArr copy];
        HMTClassifyControllerDifferentViewFrameModel *frameModel = arr[0];
        NSLog(@"%@",frameModel.tid);
        NSLog(@"%lu",(unsigned long)arr.count);
        self.modelArr = arr;
        NSLog(@"%lu",(unsigned long)result.threads.count);
        NSLog(@"%lu",(unsigned long)self.modelArr.count);
        
    } failure:^(NSError *error) {
        
    }];

}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu",(unsigned long)self.modelArr.count);
    return self.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseId = @"DifferentViewTableViewCell";
    HMTClassifyControllerDifferentViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    cell.model = self.modelArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    HMTClassifyControllerDifferentViewFrameModel *frameModel = [[HMTClassifyControllerDifferentViewFrameModel alloc]init];
    frameModel.model = self.modelArr[indexPath.row];
    return frameModel.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HMTClassifyControllerDifferentViewFrameModel *frameModel = self.modelArr[indexPath.row];
    [self pushDetialViewControllerWithTid:frameModel.tid];
    
}


-(void)pushDetialViewControllerWithTid:(NSString *)tid{
    HMTClassifyDetialTableViewController *vc = [[HMTClassifyDetialTableViewController alloc]init];
    vc.tid = tid;
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
