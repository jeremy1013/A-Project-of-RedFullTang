//
//  HMTClassifyControllerCollectionView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/1.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTClassifyControllerCollectionView.h"
#import "HMTClassifyControllerCollectionViewManager.h"

@implementation HMTClassifyControllerCollectionView{
    HMTClassifyControllerCollectionViewManager *_manager;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    //设置视图
    [self setUpViews];
}

- (void)setUpViews{
    _manager = [HMTClassifyControllerCollectionViewManager shareManager];
    self.delegate = _manager;
    self.dataSource = _manager;
    self.scrollEnabled = NO;
    self.backgroundColor = [UIColor whiteColor];
    [self registerNib:[UINib nibWithNibName:@"HMTClassifyControllerCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kHMTClassifyControllerCollectionViewCellIdentifier];
}
@end
