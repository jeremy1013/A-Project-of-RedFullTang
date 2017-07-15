//
//  HMTClassifyController.m
//  红满堂
//
//  Created by 欧阳铨 on 16/8/20.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTClassifyController.h"
#import "HMTClassifyControllerCollectionView.h"

@interface HMTClassifyController ()
@property (weak, nonatomic) IBOutlet HMTClassifyControllerCollectionView *collectionView;
@end

@implementation HMTClassifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if ([self.view window]) {
        self.view = nil;
    }
}

- (void)setUpViews{
    
}


@end
