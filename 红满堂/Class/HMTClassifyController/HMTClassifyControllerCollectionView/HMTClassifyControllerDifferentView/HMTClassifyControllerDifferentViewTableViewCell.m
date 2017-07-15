//
//  HMTClassifyControllerDifferentViewTableViewCell.m
//  红满堂
//
//  Created by Yuexi on 16/11/7.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTClassifyControllerDifferentViewTableViewCell.h"
#import "HMTClassifyControllerDifferentViewFrameModel.h"

@interface HMTClassifyControllerDifferentViewTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIImageView *cell_imaView;
@property (strong, nonatomic) IBOutlet UILabel *cell_name;
@property (strong, nonatomic) IBOutlet UILabel *cell_tittle;
@property (strong, nonatomic) IBOutlet UITextView *cell_text;
@property (strong, nonatomic) IBOutlet UILabel *cell_reply;
@property (strong, nonatomic) IBOutlet UILabel *cell_date;


@end

@implementation HMTClassifyControllerDifferentViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.detailView.backgroundColor = [UIColor whiteColor];
    self.detailView.layer.cornerRadius = 9;
    self.detailView.layer.shadowColor = rgbColor(210, 210, 210).CGColor;
    self.detailView.layer.shadowOffset = CGSizeMake(6, 6);
    self.detailView.layer.shadowOpacity = 1;
    self.detailView.layer.shadowRadius = 4;
    self.detailView.layer.shouldRasterize = YES;
    self.detailView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    self.cell_text.layer.cornerRadius = 6;
    self.cell_reply.layer.cornerRadius = 6;
    self.cell_tittle.layer.cornerRadius = 6;
    
    
    
    
    
}

-(instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.cell_name.text = [dic valueForKey:@"author"];
        self.cell_tittle.text = [dic valueForKey:@"subject"];
        self.cell_text.text = [dic valueForKey:@"message"];
    }
    return self;
}

+(instancetype)cellWithDic:(NSDictionary *)dic{
    return [[self alloc]initWithDic:dic];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(HMTClassifyControllerDifferentViewFrameModel *)model{
    _model = model;
    _cell_imaView.image = [UIImage imageNamed:model.imaView];
    _cell_name.text = model.name;
    _cell_tittle.text = model.tittle;
    _cell_text.text = model.text;
    _cell_reply.text = model.reply;
    _cell_date.text = model.dateString;
    [_cell_text setContentOffset:CGPointMake(0, 0)];
    
}

@end
