//
//  getGoodsDetailReturn.h
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/14.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DetailReturnLinkMan.h"


@interface getGoodsDetailReturn : NSObject
///支付方式
@property (nonatomic, copy) NSString *secondgoods_paidtype;
///货品描述
@property (nonatomic, copy) NSString *secondgoods_bewrite;
///货品名称
@property (nonatomic, copy) NSString *secondgoods_name;
///货品价格
@property (nonatomic, copy) NSString *secondgoods_price;
///交易方式
@property (nonatomic, copy) NSString *secondgoods_delivertype;
///交易状态
@property (nonatomic, copy) NSString *secondgoods_efficiency;
///
@property (nonatomic, copy) NSString *secondgoods_pastdate;
///货品图片
@property (nonatomic, strong) NSArray *secondgoods_picture;
///发布人信息
@property (nonatomic, strong) DetailReturnLinkMan *secondgoods_linkman;
///
@property (nonatomic, copy) NSString *replyNum;
///货物id
@property (nonatomic, copy) NSString *secondgoods_id;
///发布时间
@property (nonatomic, copy) NSString *secondgoods_postdate;
///信息性质（收购，出售）
@property (nonatomic, copy) NSString *secondgoods_tradetype;
///分类名称
@property (nonatomic, copy) NSString *cate_name;
///回复
@property (nonatomic, strong) NSArray *replyMsg;
///新旧程度
@property (nonatomic, copy) NSString *secondgoods_hownew;
///查看数
@property (nonatomic, copy) NSString *secondgoods_views;
///货品数量
@property (nonatomic, copy) NSString *secondgoods_goodsnums;
///商品有效时间
@property (nonatomic, copy) NSString *secondgoods_goodEffectTime;

@end
