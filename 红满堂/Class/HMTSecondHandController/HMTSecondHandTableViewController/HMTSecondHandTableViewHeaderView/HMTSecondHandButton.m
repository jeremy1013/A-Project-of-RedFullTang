//
//  HMTButton.m
//  红满堂
//
//  Created by Yuexi on 16/10/31.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandButton.h"

@implementation HMTSecondHandButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-20);
    CGSize size = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    self.titleLabel.frame = CGRectMake(0.5*(self.frame.size.width-size.width), self.imageView.frame.size.height, size.width, size.height);
}
@end
