//
//  getCourseCommentReturn.h
//  红满堂
//
//  Created by 欧阳铨 on 16/9/30.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "getCourseCommentModel.h"
#import "getCourseModel.h"


@interface getCourseCommentReturn : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSArray *comment;
@property (nonatomic, strong) getCourseModel *course;
@end
