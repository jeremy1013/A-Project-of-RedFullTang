//
//  NetWorkTool.m
//  myApp
//
//  Created by 欧阳铨 on 16/4/15.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "NetWorkTool.h"


static NSString *const tokenUrl = @"http://hometown.scau.edu.cn/bbs/plugin.php?id=iltc_open:userinfo";
static NSString *const courseUrl = @"http://hometown.scau.edu.cn/course/index.php?s=/Api&keyword=";
static NSString *const CourseCommentUrl = @"http://hometown.scau.edu.cn/course/index.php?s=/Api&course=";
static NSString *const getIconUrl = @"http://hometown.scau.edu.cn/bbs/uc_server/avatar.php?uid=";
static NSString *const getSecondGoods = @"http://202.116.162.22/index.php/Home/Api";
static NSString *const getGoodsDetail = @"http://202.116.162.22/index.php/Home/Api/good/id/";
static NSString *const getSecondHandClassifyGoods = @"http://202.116.162.22/index.php/Home/Api/catalog/cate/";

@implementation NetWorkTool

+ (void)postOauth2WithParams:(Oauth2Param *)param success:(void (^)(Oauth2Return *))success faliure:(void (^)(NSError *))failure{
    
    [self postWithUrlString:tokenUrl param:param resultClass:[Oauth2Return class] success:success failure:failure];
}

+ (void)getCourseWithKeyWord:(NSString *)keyWord Success:(void (^)(getCourseReturn * result))success failure:(void (^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",courseUrl,keyWord];
    url =  [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self getWithUrlString:url resultClass:[getCourseReturn class] success:success failure:failure];
}

+ (void)getCourseCommentWithID:(NSString *)ID Success:(void (^)(getCourseCommentReturn * result))success failure:(void (^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",CourseCommentUrl,ID];
    [self getWithUrlString:url resultClass:[getCourseCommentReturn class] success:success failure:failure];
    
}

+ (void)getIconWithUid:(NSString *)Uid Success:(void (^)(getIconReturn * result))success failure:(void (^)(NSError *error))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",getIconUrl,Uid];
    [self getWithUrlString:url resultClass:[getIconReturn class] success:success failure:failure];
}

+(void)getSecondGoodsWithParams:(getSecondGoodsParam *)param Success:(void (^)(getSecondGoodsReturn *))success failure:(void (^)(NSError *))failure{
//    NSString *url = @"/index/p/2?limit=5";
    NSString *url = [NSString stringWithFormat:@"%@/index/p/%@?limit=%@",getSecondGoods,param.page,param.limit];
    [self getWithUrlString:url resultClass:[getSecondGoodsReturn class] success:success failure:failure];
}

+(void)getGoodsDetailWithParams:(getGoodsDetailParam *)param Success:(void (^)(getGoodsDetailReturn *))success failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@",getGoodsDetail,param.goodID];
    [self getWithUrlString:url resultClass:[getGoodsDetailReturn class] success:success failure:failure];
}

+(void)getSecondHandClassifyGoodsWithParams:(getSecondHandClassifyGoodsParam *)param Success:(void (^)(getSecondGoodsReturn *))success failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"%@%@/p/%@?limit=%@",getSecondHandClassifyGoods,param.channel,param.page,param.limit];
    [self getWithUrlString:url resultClass:[getSecondGoodsReturn class] success:success failure:failure];
}

+(void)getClassifyViewWithParams:(getClassifyViewParam *)param Success:(void (^)(getClassifyViewModelReturn *))success failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"http://hometown.scau.edu.cn/bbs/plugin.php?id=iltc_open:thread&fid=%@&page=%@&limit=%@",param.fid,param.page,param.limit];
    [self getWithUrlString:url resultClass:[getClassifyViewModelReturn class] success:success failure:failure];
}

+(void)getClassifyViewDetialDataWithParams:(getClassifyViewDetialDataParam *)param Success:(void (^)(getClassifyViewDetialDataReturn *))success failure:(void (^)(NSError *))failure{
    NSString *url = [NSString stringWithFormat:@"http://hometown.scau.edu.cn/bbs/plugin.php?id=iltc_open:post&tid=%@&page=%@&limit=%@",param.tid,param.page,param.limit];
    [self getWithUrlString:url resultClass:[getClassifyViewDetialDataReturn class] success:success failure:failure];
}

@end
