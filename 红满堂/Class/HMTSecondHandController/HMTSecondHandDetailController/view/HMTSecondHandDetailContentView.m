//
//  HMTSecondHandDetailContentView.m
//  红满堂
//
//  Created by 欧阳铨 on 2016/10/13.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTSecondHandDetailContentView.h"
#import "getGoodsDetailReturn.h"
#import "HMTSecondHandDetailScrollView.h"
#import "UIView+Extension.h"

@interface HMTSecondHandDetailContentView ()<UIWebViewDelegate>
@property (nonatomic, assign, readwrite) CGFloat HMTSecondHandDetailContentViewHeight;
/** */
@property (nonatomic, strong) UIWebView *webview;

@end

@implementation HMTSecondHandDetailContentView

+ (instancetype)content{
    HMTSecondHandDetailContentView *view = [[HMTSecondHandDetailContentView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.HMTSecondHandDetailContentViewHeight = 0;
    return view;
}

-(void)setFrame:(CGRect)frame{
    CGRect f = frame;
    f.size = CGSizeMake(MainScreenWidth, self.HMTSecondHandDetailContentViewHeight);
    [super setFrame:f];
}


-(void)setModel:(getGoodsDetailReturn *)model{
    _model = model;
    if (self.model == nil) {
        self.HMTSecondHandDetailContentViewHeight = 0;
        return;
    }
    //根据内容和图片设置高度

    UIWebView *web = [[UIWebView alloc] init];
    web.delegate = self;
    self.webview = web;
    web.scrollView.scrollEnabled = NO;
    web.dataDetectorTypes = UIDataDetectorTypePhoneNumber|UIDataDetectorTypeLink;
    web.userInteractionEnabled = YES;
    CGFloat labelX = 20;
    CGFloat labelY = 0;
    CGFloat labelW = self.bounds.size.width - 40;
    CGFloat labelH =50;
    web.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
     NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[model.secondgoods_bewrite  dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    //HMTLog(@"%@",attrStr);
    //NSLog(@"OOYQ%@",attrStr)
    
    NSString *str = [NSString stringWithFormat:@"%@",attrStr];
    NSRange range = [str rangeOfString:@"NSColor"];
    NSString *newstr;
    if (range.length) {
        newstr = [str substringToIndex:range.location - 6];
    }
    //NSLog(@"OOYQ%@",newstr);
    
    [web loadHTMLString:newstr baseURL:nil];
    [self addSubview:web];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self setWebViewHtmlImageFitPhone];
}

- (void)setWebViewHtmlImageFitPhone
{
    CGFloat width = [[UIScreen mainScreen]bounds].size.width - 50;
    
    NSString *jsStr = [NSString stringWithFormat:@"var script = document.createElement('script');"
                       "script.type = 'text/javascript';"
                       "script.text = \"function ResizeImages() { "
                       "var myimg,oldwidth;"
                       "var maxwidth = '%f';" //自定义宽度
                       "for(i=0;i <document.images.length;i++){"
                       "myimg = document.images[i];"
                       "if(myimg.width > maxwidth){"
                       "oldwidth = myimg.width;"
                       "myimg.width = maxwidth;"
                       "}"
                       "}"
                       "}\";"
                       "document.getElementsByTagName('head')[0].appendChild(script);",width];
    [_webview stringByEvaluatingJavaScriptFromString:jsStr];
    [_webview stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    
    //根据内容高度改变scrollview的滚动范围
    CGFloat height = [[_webview stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    
    _webview.height = height;
    
    self.scrollView.contentSize = CGSizeMake(MainScreenWidth, height + 350);
    
}

@end
