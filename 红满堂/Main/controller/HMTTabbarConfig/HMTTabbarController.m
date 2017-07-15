//
//  HMTTabbarController.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/26.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTTabbarController.h"
#import "HMTTabbarItem.h"
#import "HMTUserTool.h"


CGFloat const tabbarHeight = 44;
@interface HMTTabbarController (){
    NSInteger _tabbarItemCount;
}
@property (nonatomic, strong, readwrite) UIView *tabbar;
@end

@implementation HMTTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tabbar];
}

- (UIView *)tabbar
{
    if(!_tabbar){
        self.tabbar = [[UIView alloc] init];
        self.tabbar.frame = CGRectMake(0, 0, MainScreenWidth, tabbarHeight);
        self.tabbar.backgroundColor = kSecendHandTabbarColor;
    }
    return _tabbar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTabbarItems:(NSArray *)tabbarItems{
    _tabbarItemCount = tabbarItems.count;
    for (int i = 0; i<_tabbarItemCount; i++) {
        HMTTabbarItem *item = tabbarItems[i];
        //添加item
        [self creatItemWithItem:item index:i];
    }
}

- (void)creatItemWithItem:(HMTTabbarItem *)item index:(NSInteger)index{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = index;
    [button setTitle:item.title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTag:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat buttonW = MainScreenWidth / _tabbarItemCount;
    CGFloat buttonX = index * buttonW;
    CGFloat buttonY = 0;
    CGFloat buttonH = tabbarHeight;
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    [self.tabbar addSubview:button];
}

- (void)buttonTag:(UIButton *)button{
    HMTUserModel *model = [HMTUserTool model];
    HMTLog(@"/////%@",model.username);
    switch (button.tag) {
        case 0:
            HMTLog(@"点击第0个");
            [[NSNotificationCenter defaultCenter]postNotificationName:@"clickToScroll" object:nil userInfo:@{@"key":@"0"}];
            break;
        case 1:
            HMTLog(@"点击第1个");
            [[NSNotificationCenter defaultCenter]postNotificationName:@"clickToScroll" object:nil userInfo:@{@"key":@"1"}];
            break;
        case 2:
            HMTLog(@"点击第2个");
            [[NSNotificationCenter defaultCenter]postNotificationName:@"clickToScroll" object:nil userInfo:@{@"key":@"2"}];
            break;
        default:
            break;
        
    }
}

-(void)setTabbarColor:(UIColor *)tabbarColor{
    _tabbarColor = tabbarColor;
    self.tabbar.backgroundColor = tabbarColor;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
