//
//  HMTHeaderLabelCell.h
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HMTHeaderLabelCell : UIView
+(instancetype)cellWithName:(NSString *)name;
@property (nonatomic, assign) NSInteger mark;
@end
