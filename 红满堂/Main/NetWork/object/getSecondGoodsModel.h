//
//  getSecondGoodsModel.h
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/11.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getSecondGoodsModel : NSObject
///商品id
@property (nonatomic, copy) NSString *secondgoods_id;
///价格
@property (nonatomic, copy) NSString *secondgoods_price;
///标题
@property (nonatomic, copy) NSString *secondgoods_name;
///查看数
@property (nonatomic, copy) NSString *secondgoods_views;
@property (nonatomic, copy) NSString *secondgoods_bewrite;
///上传时间
@property (nonatomic, copy) NSString *secondgoods_postdate;
///上传时间转nsdate
@property (nonatomic, copy) NSString *secondgoods_postdateString;
@property (nonatomic, copy) NSString *secondgoods_pastdate;
@property (nonatomic, copy) NSString *secondgoods_efficiency;
///商品图片
@property (nonatomic, copy) NSString *secondgoods_picture;
@property (nonatomic, copy) NSString *members_username;
@property (nonatomic, copy) NSString *members_truename;
///用户头像
@property (nonatomic, copy) NSString *members_pic;
@end
