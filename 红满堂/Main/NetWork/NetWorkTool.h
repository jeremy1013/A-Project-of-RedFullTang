//
//  NetWorkTool.h
//  myApp
//
//  Created by 欧阳铨 on 16/4/15.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OYQNetworkBase.h"

#import "Oauth2Param.h"
#import "Oauth2Return.h"

#import "getCourseReturn.h"

#import "getCourseCommentReturn.h"

#import "getIconReturn.h"

#import "getSecondGoodsParam.h"
#import "getSecondGoodsReturn.h"

#import "getGoodsDetailParam.h"
#import "getGoodsDetailReturn.h"
#import "getSecondHandClassifyGoodsParam.h"
#import "getClassifyViewParam.h"
#import "getClassifyViewModelReturn.h"
#import "getClassifyViewDetialDataParam.h"
#import "getClassifyViewDetialDataReturn.h"
@interface NetWorkTool : OYQNetworkBase
/**
 *  获取用户信息
 *
 *  @param param
 *  @param success 成功的回调
 *  @param failure 失败后的回调
 */
+ (void)postOauth2WithParams:(Oauth2Param *)param success:(void (^)(Oauth2Return * result))success faliure:(void (^)(NSError *error))failure;


#warning 现在直接返回图片。接口要改为返回图片连接
/**
 *  获取发帖者的头像
 *
 *  @param Uid 发帖者uid
 *  @param success 成功的回调
 *  @param failure 失败后的回调
 */
+ (void)getIconWithUid:(NSString *)Uid Success:(void (^)(getIconReturn * result))success failure:(void (^)(NSError *error))failure;


/**
 *  根据搜索的关键字返回相关课程名含该关键字的课程的数据
 *
 *  @param keyWord 关键词
 *  @param success 成功的回调
 *  @param failure 失败后的回调
 */
+ (void)getCourseWithKeyWord:(NSString *)keyWord Success:(void (^)(getCourseReturn * result))success failure:(void (^)(NSError *error))failure;


/**
 *  获取某一课程評論
 *
 *  @param ID 课程id
 *  @param success 成功的回调
 *  @param failure 失败后的回调
 */
+ (void)getCourseCommentWithID:(NSString *)ID Success:(void (^)(getCourseCommentReturn * result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取二手物品数据
 *
 *  @param param 
 *  @param success 成功的回调
 *  @param failure 失败后的回调
 */
+ (void)getSecondGoodsWithParams:(getSecondGoodsParam *)param Success:(void (^)(getSecondGoodsReturn * result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取二手物品详情
 *
 *  @param param
 *  @param success 成功的回调
 *  @param failure 失败后的回调
 */
+ (void)getGoodsDetailWithParams:(getGoodsDetailParam *)param Success:(void (^)(getGoodsDetailReturn * result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取二手分类物品数据
 *
 *  @param param
 *  @param success 成功的回调
 *  @param failure 失败后的回调
 */
+ (void)getSecondHandClassifyGoodsWithParams:(getSecondHandClassifyGoodsParam *)param Success:(void (^)(getSecondGoodsReturn * result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取分类界面
 *
 *  @param param
 *  @param success 成功的回调
 *  @param failure 失败后的回调
 */
+ (void)getClassifyViewWithParams:(getClassifyViewParam *)param Success:(void (^)(getClassifyViewModelReturn * result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取分类界面贴吧详细内容
 *
 *  @param param
 *  @param success 成功的回调
 *  @param failure 失败后的回调
 */
+ (void)getClassifyViewDetialDataWithParams:(getClassifyViewDetialDataParam *)param Success:(void (^)(getClassifyViewDetialDataReturn * result))success failure:(void (^)(NSError *error))failure;

@end
