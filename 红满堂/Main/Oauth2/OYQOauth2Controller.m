//
//  OYQOauth2Controller.m
//  Oauth2
//
//  Created by 欧阳铨 on 16/8/20.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "OYQOauth2Controller.h"
#import "NetWorkTool.h"
#import "NSString+Extension.h"
#import "HMTUserModel.h"
#import "HMTTokenTool.h"
#import "HMTTokenModel.h"
#import "HMTUserTool.h"
#import "HMTTool.h"

static NSString *const authorizeUrl = @"http://hometown.scau.edu.cn/open/OAuth/authorize";
static NSString *const client_id = @"8";
static NSString *const redirect_uri = @"localhost";
static NSString *const state = @"OYQUaX94z0QAdrX4G2t2eTidkI1jOfhi";
static NSString *const response_type = @"token";
static NSString *const scope = @"";
static NSString *const appSecret = @"XB6Q3z3cPXp04xe58XEh157FEFum3vP7";
static NSString *const tokenUrl = @"http://hometown.scau.edu.cn/open/OAuth/access_token";


@interface OYQOauth2Controller ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, assign) BOOL isReload;

@end

@implementation OYQOauth2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = NO;
    self.webView.delegate = self;
    //如果报错(kCFStreamErrorDomainSSL, -9802)
    //在INFO加上
    /*
    <key>NSAppTransportSecurity</key>
    <dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    </dict>
     */
    [self loadLogInUrl];
    
}

- (void)loadLogInUrl{
    NSString *urlString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_url=%@&state=%@&response_type=%@&scope=%@",authorizeUrl, client_id, redirect_uri, state, response_type, scope];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self.view window] == nil) {
        self.view = nil;
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 1.获得url
    NSString *url = request.URL.absoluteString;
    NSLog(@"%@",url);
    // 2.判断是否为回调地址
    NSRange tokenRange = [url rangeOfString:@"access_token="];
    if (tokenRange.length != 0) { // 是回调地址
        HMTTokenModel *model = [[HMTTokenModel alloc] init];
        model.access_token = [NSString subStringWithName:@"access_token" inUrl:url];
        model.expires_in = [NSString subStringWithName:@"expires_in" inUrl:url];
        model.uid = [NSString subStringWithName:@"uid" inUrl:url];
        model.date = [NSDate date];
        [HMTTokenTool saveTokenModel:model];
        // 利用uid换取用户信息
        [self accessTokenWithUid:model.uid];
        //发送成功登录通知
        [HMTTool makeToast:@"登录成功"];
        NSNotification *notification = [[NSNotification alloc] initWithName:KNotificationLogIn object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:NO];
    }
    //3.是否是code登录
     NSRange codeRange = [url rangeOfString:@"receive=yes"];
    if (codeRange.length != 0) {
        
        self.isReload = YES;
        
//        [self.navigationController popViewControllerAnimated:NO];
        
    }
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    if (self.isReload) {
        [self loadLogInUrl];
    }
    
}

- (void)accessTokenWithUid:(NSString *)uid
{
    Oauth2Param *param = [[Oauth2Param alloc] init];
    param.uid = uid;
    [NetWorkTool postOauth2WithParams:param success:^(Oauth2Return *result) {
        //存储帐号
        [HMTUserTool saveUserModel:result.data];
    } faliure:^(NSError *error) {
        
    }];

}
@end
