//
//  HMTClassifyControllerCollectionViewManager.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/1.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTClassifyControllerCollectionViewManager.h"
#import "HMTClassifyControllerCollectionViewCell.h"
#import "HMTClassifyControllerCollectionView.h"

#import "HMTClassifyControllerDifferentViewTableViewController.h"
#import "HMTTool.h"
#import "HMTClassifyControllerCollectionViewModel.h"

@interface HMTClassifyControllerCollectionViewManager ()
@property (nonatomic, strong) HMTClassifyControllerCollectionView *collectionView;
@property (strong, nonatomic)  NSArray *arr;

@end

@implementation HMTClassifyControllerCollectionViewManager

-(NSArray *)arr{
    if (_arr == nil) {
        NSMutableArray *mutArr = [NSMutableArray array];
        HMTClassifyControllerCollectionViewModel *model0 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model0.lblName = @"职场交流";
        model0.imgName = @"0";
        [mutArr addObject:model0];
        HMTClassifyControllerCollectionViewModel *model1 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model1.lblName = @"课程交流";
        model1.imgName = @"1";
        [mutArr addObject:model1];
        HMTClassifyControllerCollectionViewModel *model2 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model2.lblName = @"海洋馆";
        model2.imgName = @"1";
        [mutArr addObject:model2];
        HMTClassifyControllerCollectionViewModel *model3 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model3.lblName = @"体坛风云";
        model3.imgName = @"0";
        [mutArr addObject:model3];
        HMTClassifyControllerCollectionViewModel *model4 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model4.lblName = @"音乐坊";
        model4.imgName = @"0";
        [mutArr addObject:model4];
        HMTClassifyControllerCollectionViewModel *model5 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model5.lblName = @"影视分享";
        model5.imgName = @"2";
        [mutArr addObject:model5];
        HMTClassifyControllerCollectionViewModel *model6 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model6.lblName = @"情感宣泄";
        model6.imgName = @"0";
        [mutArr addObject:model6];
        HMTClassifyControllerCollectionViewModel *model7 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model7.lblName = @"文学社";
        model7.imgName = @"0";
        [mutArr addObject:model7];
        HMTClassifyControllerCollectionViewModel *model8 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model8.lblName = @"生活百科";
        model8.imgName = @"0";
        [mutArr addObject:model8];
        HMTClassifyControllerCollectionViewModel *model9 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model9.lblName = @"同道堂";
        model9.imgName = @"2";
        [mutArr addObject:model9];
        HMTClassifyControllerCollectionViewModel *model10 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model10.lblName = @"广而告之";
        model10.imgName = @"1";
        [mutArr addObject:model10];
        HMTClassifyControllerCollectionViewModel *model11 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model11.lblName = @"游戏版";
        model11.imgName = @"0";
        [mutArr addObject:model11];
        HMTClassifyControllerCollectionViewModel *model12 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model12.lblName = @"兼职地带";
        model12.imgName = @"2";
        [mutArr addObject:model12];
        HMTClassifyControllerCollectionViewModel *model13 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model13.lblName = @"论坛站务";
        model13.imgName = @"2";
        [mutArr addObject:model13];
        HMTClassifyControllerCollectionViewModel *model14 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model14.lblName = @"深度思考";
        model14.imgName = @"0";
        [mutArr addObject:model14];
        HMTClassifyControllerCollectionViewModel *model15 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model15.lblName = @"二手市场";
        model15.imgName = @"1";
        [mutArr addObject:model15];
        HMTClassifyControllerCollectionViewModel *model16 = [[HMTClassifyControllerCollectionViewModel alloc]init];
        model16.lblName = @"社团组织招新";
        model16.imgName = @"2";
        [mutArr addObject:model16];
        _arr = mutArr;
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)shareManager{
    static HMTClassifyControllerCollectionViewManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HMTClassifyControllerCollectionViewManager alloc] init];
    });
    return manager;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    self.collectionView = (HMTClassifyControllerCollectionView *)collectionView;
    return self.arr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HMTClassifyControllerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHMTClassifyControllerCollectionViewCellIdentifier forIndexPath:indexPath];
    HMTClassifyControllerCollectionViewModel *model = self.arr[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HMTClassifyControllerDifferentViewTableViewController *tableViewController = [[HMTClassifyControllerDifferentViewTableViewController alloc]init];
    tableViewController.clickChannel = [self getCollectionViewClickChannel:indexPath.row];
    UINavigationController *nav = [HMTTool getPushNavigation];
    [nav pushViewController:tableViewController animated:YES];
    HMTLog(@"%ld",(long)indexPath.row);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){MainScreenWidth / 4,MainScreenWidth / 4};
}

//行间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//竖间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(NSString *)getCollectionViewClickChannel:(NSInteger)channel{
    NSString *channelStr = nil;
    if (channel == 0) {
        channelStr = @"54";
    }else if (channel == 1){
        channelStr = @"11";
    }else if (channel == 2){
        channelStr = @"7";
    }else if (channel == 3){
        channelStr = @"44";
    }else if (channel == 4){
        channelStr = @"79";
    }else if (channel == 5){
        channelStr = @"73";
    }else if (channel == 6){
        channelStr = @"36";
    }else if (channel == 7){
        channelStr = @"47";
    }else if (channel == 8){
        channelStr = @"12";
    }else if (channel == 9){
        channelStr = @"136";
    }else if (channel == 10){
        channelStr = @"101";
    }else if (channel == 11){
        channelStr = @"110";
    }else if (channel == 12){
        channelStr = @"142";
    }else if (channel == 13){
        channelStr = @"39";
    }else if (channel == 14){
        channelStr = @"55";
    }else if (channel == 15){
        channelStr = @"95";
    }else if (channel == 16){
        channelStr = @"145";
    }
    
    return channelStr;
}
@end
