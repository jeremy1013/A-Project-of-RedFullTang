//
//  HMTSecondHandTableViewCell.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/18.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandTableViewCell.h"
#import "getSecondGoodsModel.h"
#import "YYWebImage.h"

@interface HMTSecondHandTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *answerTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *detailView;

@end

@implementation HMTSecondHandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.shouldRasterize = YES;
    
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    self.detailView.layer.cornerRadius = 9;
    self.detailView.layer.shadowColor = rgbColor(210, 210, 210).CGColor;
    self.detailView.layer.shadowOffset = CGSizeMake(4, 4);
    self.detailView.layer.shadowOpacity = 0.8;
    self.detailView.layer.shadowRadius = 4;
    self.detailView.layer.shouldRasterize = YES;
    self.detailView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    
    self.checkLabel.layer.borderWidth = 1;
    self.checkLabel.layer.borderColor = rgbColor(135, 135, 135).CGColor;
    self.checkLabel.layer.cornerRadius = self.checkLabel.bounds.size.height / 2;
//    self.checkLabel.layer.masksToBounds = YES;
    self.checkLabel.layer.shouldRasterize = YES;
    self.checkLabel.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.height / 2;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.shouldRasterize = YES;
    self.iconImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    self.goodsImageview.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(getSecondGoodsModel *)model{
    _model = model;
    self.titleLabel.text = model.secondgoods_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%ld",model.secondgoods_price.integerValue];
    self.answerTimeLabel.text = model.secondgoods_postdateString;
    self.checkLabel.text = [NSString stringWithFormat:@"查看%ld",model.secondgoods_views.integerValue];
    //商品图片
    
    if (model.secondgoods_picture) {
        NSURL *url = [NSURL URLWithString:model.secondgoods_picture];
        [self.goodsImageview yy_setImageWithURL:url options:YYWebImageOptionProgressive];
    }else{
        self.goodsImageview.image = [UIImage imageNamed:@"userDefault"];
    }
    
    if (model.members_pic) {
        NSURL *url = [NSURL URLWithString:model.members_pic];
        [self.iconImageView yy_setImageWithURL:url options:YYWebImageOptionProgressive];
    }else{
        self.iconImageView.image = [UIImage imageNamed:@"userDefault"];
    }
}
@end
