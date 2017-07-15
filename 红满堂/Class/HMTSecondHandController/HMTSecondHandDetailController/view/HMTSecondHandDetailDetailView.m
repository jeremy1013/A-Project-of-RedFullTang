//
//  HMTSecondHandDetailDetailView.m
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/13.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandDetailDetailView.h"
#import "getGoodsDetailReturn.h"

CGFloat const HMTSecondHandDetailDetailViewHeigth = 180;

@interface HMTSecondHandDetailDetailView ()
/** label的数组*/
@property (nonatomic, strong) NSMutableArray *labelArr;
/** text的数组*/
@property (nonatomic, strong) NSMutableArray *textArr;
@end

@implementation HMTSecondHandDetailDetailView

+ (instancetype)detail{
    HMTSecondHandDetailDetailView *view = [[HMTSecondHandDetailDetailView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [view setUpViews];
    return view;
}


- (NSMutableArray *)labelArr
{
    if(!_labelArr){
        self.labelArr = [NSMutableArray array];
    }
    return _labelArr;
}

- (NSMutableArray *)textArr
{
    if(!_textArr){
        self.textArr = [NSMutableArray array];
        [self.textArr addObject:@"新旧程度："];
        [self.textArr addObject:@"交易方式："];
        [self.textArr addObject:@"付款方式："];
        [self.textArr addObject:@"商品有效时间"];
        [self.textArr addObject:@""];
        [self.textArr addObject:@"商品描述："];
    }
    return _textArr;
}

-(void)setFrame:(CGRect)frame{
    CGRect f = frame;
    f.size = CGSizeMake(MainScreenWidth, HMTSecondHandDetailDetailViewHeigth);
    [super setFrame:f];
}

- (void)setUpViews{
    CGFloat x = 20;
    CGFloat w = self.bounds.size.width - 20;
    CGFloat h = 30;
    for (int i = 0; i<6; i++) {
        UILabel *label = [[UILabel alloc] init];
        [self.labelArr addObject:label];
        CGFloat y = i * h;
        label.frame = CGRectMake(x, y, w, h);
        [self addSubview:label];
    }
    [self setLabelText];
    
}

- (void)setLabelText{
    for (int i = 0; i<6; i++) {
        UILabel *label = (UILabel *)self.labelArr[i];
        label.text = self.textArr[i];
    }
}

-(void)setModel:(getGoodsDetailReturn *)model{
    _model = model;
    
    for (int i = 0; i<6; i++) {
        UILabel *label = self.labelArr[i];
        switch (i) {
            case 0:
                label.text = [NSString stringWithFormat:@"%@%@",label.text,model.secondgoods_hownew];
                break;
            case 1:
                label.text = [NSString stringWithFormat:@"%@%@",label.text,model.secondgoods_delivertype];
                break;
            case 2:
                label.text = [NSString stringWithFormat:@"%@%@",label.text,model.secondgoods_paidtype];
                break;
            case 3:
                
                break;
            case 4:
                label.text = [NSString stringWithFormat:@"%@%@",label.text,model.secondgoods_goodEffectTime];
                break;
            case 5:
                
                break;
            default:
                break;
        }
    }
}
@end
