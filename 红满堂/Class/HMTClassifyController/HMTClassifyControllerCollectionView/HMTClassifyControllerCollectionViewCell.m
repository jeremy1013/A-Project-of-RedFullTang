//
//  HMTClassifyControllerCollectionViewCell.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/1.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTClassifyControllerCollectionViewCell.h"
#import "HMTClassifyControllerCollectionViewModel.h"

@implementation HMTClassifyControllerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)setModel:(HMTClassifyControllerCollectionViewModel *)model{
    _model = model;
    _cellLabel.text = model.lblName;
    _cellImgView.image = [UIImage imageNamed:model.imgName];
}

@end
