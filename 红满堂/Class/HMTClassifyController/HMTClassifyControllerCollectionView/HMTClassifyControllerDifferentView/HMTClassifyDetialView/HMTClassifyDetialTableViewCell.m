//
//  HMTClassifyDetialTableViewCell.m
//  红满堂
//
//  Created by Yuexi on 17/3/9.
//  Copyright © 2017年 欧阳铨. All rights reserved.
//

#import "HMTClassifyDetialTableViewCell.h"

@implementation HMTClassifyDetialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.detialView.backgroundColor = [UIColor whiteColor];
    self.detialView.layer.cornerRadius = 9;
    self.detialView.layer.shadowColor = rgbColor(210, 210, 210).CGColor;
    self.detialView.layer.shadowOffset = CGSizeMake(6, 6);
    self.detialView.layer.shadowOpacity = 1;
    self.detialView.layer.shadowRadius = 4;
    self.detialView.layer.shouldRasterize = YES;
    self.detialView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
