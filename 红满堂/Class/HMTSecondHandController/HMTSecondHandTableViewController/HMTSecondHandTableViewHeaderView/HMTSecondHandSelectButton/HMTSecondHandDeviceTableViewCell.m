//
//  HMTSecondHandDeviceTableViewCell.m
//  红满堂
//
//  Created by Yuexi on 16/11/20.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandDeviceTableViewCell.h"
#import "HMTSecondHandDeviceModel.h"
#import "getSecondGoodsModel.h"
#import "YYWebImage.h"
@implementation HMTSecondHandDeviceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.backgroundColor = [UIColor clearColor];
    self.detailView.backgroundColor = [UIColor whiteColor];
    self.detailView.layer.cornerRadius = 9;
    self.detailView.layer.shadowColor = rgbColor(210, 210, 210).CGColor;
    self.detailView.layer.shadowOffset = CGSizeMake(6, 4);
    self.detailView.layer.shadowOpacity = 0.8;
    self.detailView.layer.shadowRadius = 4;
    self.detailView.layer.shouldRasterize = YES;
    self.detailView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(getSecondGoodsModel *)model{
    _model = model;
    self.tittle.text = model.secondgoods_name;
    self.price.text = model.secondgoods_price;
    self.date.text = model.secondgoods_postdateString;
    self.viewcount.text = [NSString stringWithFormat:@"查看 %@",model.secondgoods_views];
    if (model.secondgoods_picture) {
        NSURL *url = [NSURL URLWithString:model.secondgoods_picture];
        [self.imgView yy_setImageWithURL:url options:YYWebImageOptionProgressive];
    }else{
        self.imgView.image = [UIImage imageNamed:@"userDefault"];
    }
}

@end
