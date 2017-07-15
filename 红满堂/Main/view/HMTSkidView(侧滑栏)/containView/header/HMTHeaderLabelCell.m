//
//  HMTHeaderLabelCell.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTHeaderLabelCell.h"



@implementation HMTHeaderLabelCell{
    UILabel *_nameLabel;
    UILabel *_markLabel;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置视图
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews{
    _nameLabel = [[UILabel alloc] init];
    
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    
    _markLabel = [[UILabel alloc] init];
    
    _markLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_markLabel];
    
}

-(void)setFrame:(CGRect)frame{
    _nameLabel.frame = CGRectMake(0, 0, frame.size.width, frame.size.height / 2);
    _markLabel.frame = CGRectMake(0, CGRectGetMaxY(_nameLabel.frame), frame.size.width, frame.size.height / 2);
    [super setFrame:frame];
}

+(instancetype)cellWithName:(NSString *)name{
    HMTHeaderLabelCell *cell = [[HMTHeaderLabelCell alloc] initWithFrame:CGRectZero];
    [cell setName:name];
    return cell;
}

- (void)setName:(NSString *)name{
    _nameLabel.text = name;
}

-(void)setMark:(NSInteger)mark{
    _mark = mark;
    _markLabel.text = mark?[NSString stringWithFormat:@"%ld",(long)mark]:@"-";
}

@end
