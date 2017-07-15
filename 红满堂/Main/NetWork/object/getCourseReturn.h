//
//  getCourseReturn.h
//  红满堂
//
//  Created by 欧阳铨 on 16/9/30.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "getCourseModel.h"
@interface getCourseReturn : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSString *keyword;
@end
