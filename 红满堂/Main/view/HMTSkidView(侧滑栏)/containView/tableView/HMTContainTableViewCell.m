//
//  HMTContainTableViewCell.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTContainTableViewCell.h"
#import "HMTContainTableViewModel.h"

@interface HMTContainTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation HMTContainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(HMTContainTableViewModel *)model{
    self.image.image = [UIImage imageNamed:model.imageName];
    self.title.text = model.title;
}

@end
