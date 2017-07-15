//
//  HMTHeaderLabel.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTHeaderLabel.h"
#import "HMTHeaderLabelCell.h"
#import "HMTUserModel.h"
#import "HMTUserTool.h"


@interface HMTHeaderLabel()
/** 魅力*/
@property (nonatomic, strong) HMTHeaderLabelCell *ml;
/** 薯片*/
@property (nonatomic, strong) HMTHeaderLabelCell *sp;
/** 积分*/
@property (nonatomic, strong) HMTHeaderLabelCell *credits;
@end

@implementation HMTHeaderLabel{
    CGFloat _w;
    CGFloat _h;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        //设置视图
        [self setUpViews];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    _w = frame.size.width;
    _h = frame.size.height;
    [super setFrame:frame];
}

- (void)setUpViews{
    //创建cell
    NSMutableArray *cells = [NSMutableArray array];
    HMTHeaderLabelCell *cell0 =[HMTHeaderLabelCell cellWithName:@"魅力"];
    self.ml = cell0;
    [cells addObject:cell0];
    
    HMTHeaderLabelCell *cell1 =[HMTHeaderLabelCell cellWithName:@"薯片"];
    self.sp = cell1;
    [cells addObject:cell1];
    
    HMTHeaderLabelCell *cell2 =[HMTHeaderLabelCell cellWithName:@"积分"];
    self.credits = cell2;
    [cells addObject:cell2];
    
    //设置cell的frame
    CGFloat w = _w / cells.count;
    CGFloat h = _h;
    for (int i = 0; i<cells.count; i++) {
        CGFloat x = i * w;
        CGFloat y = 0;
        UIView *cell = cells[i];
        cell.frame = CGRectMake(x, y, w, h);
        [self addSubview:cell];
    }
    
    //设置cell的数值
    [self setCellsText];
    
    //通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCellsText) name:KNotificationLogOut object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCellsText) name:KNotificationLogIn object:nil];
}

- (void)setCellsText{
    HMTUserModel *model = [HMTUserTool model];
    self.ml.mark = model ? model.ml.integerValue : nil;
    self.sp.mark = model ? model.sp.integerValue : nil;
    self.credits.mark = model ? model.credits.integerValue : nil;
    
}
@end
