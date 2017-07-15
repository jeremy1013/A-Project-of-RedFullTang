//
//  HMTBaseViewController.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/21.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTBaseViewController.h"
#import "HMTHeaderView.h"
#import "HMTScrollVIew.h"
#import "UIImage+imageOfColor.h"
#import "HMTSkidView.h"
#import "UIColor+Extension.h"

@interface HMTBaseViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet HMTHeaderView *headerView;
@property (weak, nonatomic) IBOutlet HMTScrollVIew *scrollView;
@property (nonatomic, assign) CGFloat lastOffset;


@end

@implementation HMTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavigationBar];
    self.scrollView.delegate = self;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clickToScroll:) name:@"clickToScroll" object:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"clickToScroll" object:nil userInfo:@{@"key" : @"1"}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window]) {
        self.view = nil;
    }
}

-(void)clickToScroll:(NSNotification *)noti {
    
    
    NSDictionary *dic = noti.userInfo;
    if ([[dic objectForKey:@"key"] isEqual:@"0"]) {
        CGPoint poi = CGPointMake(0, 0);
        [self.scrollView setContentOffset:poi animated:YES];
        [self.scrollView addSecondHandVC];
    }else if ([[dic objectForKey:@"key"] isEqual:@"1"]){
        CGPoint poi = CGPointMake(self.scrollView.frame.size.width, 0);
        [self.scrollView setContentOffset:poi animated:YES];
        [self.scrollView addRecommendVC];
    }else if ([[dic objectForKey:@"key"] isEqual:@"2"]){
        CGPoint poi = CGPointMake(self.scrollView.frame.size.width*2, 0);
        [self.scrollView setContentOffset:poi animated:YES];
        [self.scrollView addClassifyVC];
    }
}

- (void)setNavigationBar{
    //设置左边按钮的内容
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"测试" style:UIBarButtonItemStylePlain target:self action:@selector(navColorChange)];
    [self.navigationItem setLeftBarButtonItem:item];
    //titleview
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, MainScreenWidth, 44);
    label.text = @"华农人的红满堂";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:22.0];
    [self.navigationItem setTitleView:label];
}

- (void)navColorChange{
    [HMTSkidView show];
//        UIImage *tabBarBG = [UIImage imageWithColor:[UIColor greenColor]];
//        [self.navigationController.navigationBar setBackgroundImage:tabBarBG forBarMetrics:UIBarMetricsDefault];
//        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    
    BOOL isLeft = YES;//yes是向右翻页:二手-》推荐-》分区
    if (self.lastOffset < offset) {
        isLeft = YES;
        NSLog(@"yes");
    }else if (self.lastOffset > offset){
        isLeft = NO;
        NSLog(@"no");
    }
    
    
    
    self.headerView.offset = offset;

    UIImage *tabBarBG = [UIImage imageWithColor:[UIColor colorWithOffset:scrollView.contentOffset.x]];
    [self.navigationController.navigationBar setBackgroundImage:tabBarBG forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor colorWithOffset:scrollView.contentOffset.x]];
    
    double page = scrollView.contentOffset.x / scrollView.frame.size.width;
//    int currentPage = (int)(page + 0.5);  //四舍五入计算出页码
    int currentPage;
    if (isLeft) {
        currentPage = (int)(page + 0.95);  //四舍五入计算出页码
    }else{
        currentPage = (int)(page + 0.05);  //四舍五入计算出页码
    }
    
    HMTLog(@"%d",currentPage);
    
//    if (currentPage == 0) {
//        [self.scrollView removeClassifyVC];
//    }else if (currentPage == 1){
//        [self.scrollView addClassifyVC];
//        [self.scrollView addSecondHandVC];
//    }else if (currentPage == 2){
//        [self.scrollView removeSecondHandVC];
//    }
    
//    if (currentPage == 0) {
//        [self.scrollView addSecondHandVC];
//        [self.scrollView removeClassifyVC];
//        [self.scrollView removeRecommendVC];
//    }else if (currentPage == 1){
//        [self.scrollView addRecommendVC];
//        [self.scrollView removeClassifyVC];
//        [self.scrollView removeSecondHandVC];
//    }else if (currentPage == 2){
//        [self.scrollView addClassifyVC];
//        [self.scrollView removeRecommendVC];
//        [self.scrollView removeSecondHandVC];
//    }
    
    
    
    if (currentPage == 0) {
        [self.scrollView addSecondHandVC];
    }else if (currentPage == 1){
        [self.scrollView addRecommendVC];
    }else if (currentPage == 2){
        [self.scrollView addClassifyVC];
        if ([self.navigationController isNavigationBarHidden]) {
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }
    
    self.lastOffset = offset;
}

//scrollview停止滚动时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    double page = scrollView.contentOffset.x / scrollView.frame.size.width;
    int currentPage = (int)(page + 0.5);  //四舍五入计算出页码
    if (currentPage == 0) {
        [self.scrollView removeClassifyVC];
        [self.scrollView removeRecommendVC];
    }else if (currentPage == 1){
        [self.scrollView removeClassifyVC];
        [self.scrollView removeSecondHandVC];
    }else if (currentPage == 2){
        [self.scrollView removeRecommendVC];
        [self.scrollView removeSecondHandVC];
    }
}
@end
