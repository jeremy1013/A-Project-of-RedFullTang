//
//  HMTClassifyControllerCollectionViewCell.h
//  红满堂
//
//  Created by 欧阳铨 on 16/9/1.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMTClassifyControllerCollectionViewModel;

@interface HMTClassifyControllerCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *cellLabel;
@property (strong, nonatomic) IBOutlet UIImageView *cellImgView;
@property (strong, nonatomic)  HMTClassifyControllerCollectionViewModel *model;
@end
