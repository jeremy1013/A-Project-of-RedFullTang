//
//  HMTSecondHandDeviceTableViewCell.h
//  红满堂
//
//  Created by Yuexi on 16/11/20.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>
@class getSecondGoodsModel;
@interface HMTSecondHandDeviceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *tittle;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *viewcount;
@property (strong, nonatomic)  getSecondGoodsModel *model;
@end
