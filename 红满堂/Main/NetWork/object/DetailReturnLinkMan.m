//
//  DetailReturnLinkMan.m
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/14.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "DetailReturnLinkMan.h"

@implementation DetailReturnLinkMan
-(void)setMembers_pic:(NSString *)members_pic{
    
    if (![members_pic isEqualToString:@""]) {
        NSString *str = [NSString stringWithFormat:@"%@%@",@"http://market.scau.edu.cn/Uploads/",members_pic];
        _members_pic = str;
    }else{
        _members_pic = nil;
    }
}
@end
