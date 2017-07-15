//
//  HMTUserModel.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/27.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTUserModel.h"

static NSString  * const KUidKey = @"uid";
static NSString  * const KusernameKey = @"username";
static NSString  * const KemailKey = @"email";
static NSString  * const KadminidKey = @"adminid";
static NSString  * const KgroupidKey = @"groupid";
static NSString  * const KextgroupidsKey = @"extgroupids";
static NSString  * const KallowadmincpKey = @"allowadmincp";
static NSString  * const KcreditsKey = @"credits";
static NSString  * const KnewpmKey = @"newpm";
static NSString  * const KmlKey = @"ml";
static NSString  * const KspKey = @"sp";
static NSString  * const KavatarKey = @"avatar";

#define groupIDDict dict = @{@"1":@"管理员", @"2":@"超級版主", @"3":@"版主", @"4":@"禁止發言", @"5":@"禁止訪問", @"6":@"禁止 IP", @"7":@"遊客", @"8":@"等待驗證會員", @"9":@"红薯學前班", @"10":@"红薯小學生", @"11":@"红薯高中生", @"12":@"红薯本科生", @"13":@"红薯碩士生", @"14":@"红薯博士生", @"15":@"红薯博士後", @"16":@"红薯副教授", @"17":@"红薯教授", @"21":@"靈魂人物", @"25":@"红薯初中生", @"26":@"实习版主", @"30":@"广告杀手", @"32":@"专长红薯", @"33":@"PT组", @"34":@"版主", @"35":@"Metc专用组", @"37":@"红满堂应用部", @"41":@"保卫处", @"42":@"Ad专用组", @"43":@"视角专员", @"44":@"退休人员", @"45":@"QQ游客", @"46":@"红满堂维护组"};

@interface HMTUserModel ()
@property (nonatomic, strong) NSDictionary *groupIdDict;

@end

@implementation HMTUserModel

-(NSDictionary *)groupIdDict
{
    if(!_groupIdDict){
        self.groupIdDict = [NSDictionary dictionaryWithObjectsAndKeys:@"管理员" , @"1",
                                                                      @"超級版主" , @"2",
                                                                      @"版主" , @"3",
                                                                      @"禁止發言" , @"4",
                                                                      @"禁止訪問" , @"5",
                                                                      @"禁止 IP" , @"6",
                                                                      @"遊客" , @"7",
                                                                      @"等待驗證會員" , @"8",
                                                                      @"红薯學前班" , @"9",
                                                                      @"红薯小學生" , @"10",
                                                                      @"红薯高中生" , @"11",
                                                                      @"红薯本科生" , @"12",
                                                                      @"红薯碩士生" , @"13",
                                                                      @"红薯博士生" , @"14",
                                                                      @"红薯博士後" , @"15",
                                                                      @"红薯副教授" , @"16",
                                                                      @"红薯教授" , @"17",
                                                                      @"靈魂人物" , @"21",
                                                                      @"红薯初中生" , @"25",
                                                                      @"实习版主" , @"26",
                                                                      @"广告杀手" , @"30",
                                                                      @"专长红薯" , @"32",
                                                                      @"PT组" , @"33",
                                                                      @"版主" , @"34",
                                                                      @"Metc专用组" , @"35",
                                                                      @"红满堂应用部"  ,@"37",
                                                                      @"保卫处" , @"41",
                                                                      @"Ad专用组" , @"42",
                                                                      @"视角专员" , @"43",
                                                                      @"退休人员" , @"44",
                                                                      @"QQ游客" , @"45",
                                                                      @"红满堂维护组" , @"46",  nil];
    }
    return _groupIdDict;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.uid = [aDecoder decodeObjectForKey:KUidKey];
        self.username = [aDecoder decodeObjectForKey:KusernameKey];
        self.email = [aDecoder decodeObjectForKey:KemailKey];
        self.adminid = [aDecoder decodeObjectForKey:KadminidKey];
        self.groupid = [aDecoder decodeObjectForKey:KgroupidKey];
        self.extgroupids = [aDecoder decodeObjectForKey:KextgroupidsKey];
        self.allowadmincp = [aDecoder decodeObjectForKey:KallowadmincpKey];
        self.credits = [aDecoder decodeObjectForKey:KcreditsKey];
        self.newpm = [aDecoder decodeObjectForKey:KnewpmKey];
        self.ml = [aDecoder decodeObjectForKey:KmlKey];
        self.sp = [aDecoder decodeObjectForKey:KspKey];
        self.avatar = [aDecoder decodeObjectForKey:KavatarKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)enCoder{
    [enCoder encodeObject:self.uid forKey:KUidKey];
    [enCoder encodeObject:self.username forKey:KusernameKey];
    [enCoder encodeObject:self.email forKey:KemailKey];
    [enCoder encodeObject:self.adminid forKey:KadminidKey];
    [enCoder encodeObject:self.groupid forKey:KgroupidKey];
    [enCoder encodeObject:self.extgroupids forKey:KextgroupidsKey];
    [enCoder encodeObject:self.allowadmincp forKey:KallowadmincpKey];
    [enCoder encodeObject:self.credits forKey:KcreditsKey];
    [enCoder encodeObject:self.newpm forKey:KnewpmKey];
    [enCoder encodeObject:self.ml forKey:KmlKey];
    [enCoder encodeObject:self.sp forKey:KspKey];
    [enCoder encodeObject:self.avatar forKey:KavatarKey];
}

-(void)setGroupid:(NSString *)groupid{
    _groupid = groupid;
    self.groupidName = [self.groupIdDict objectForKey:self.groupid];
    
}



@end

