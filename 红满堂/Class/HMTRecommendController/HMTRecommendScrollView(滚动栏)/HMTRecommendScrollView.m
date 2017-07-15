//
//  HMTRecommendScrollView.m
//  红满堂
//
//  Created by 欧阳铨 on 16/9/3.
//  Copyright © 2016年 欧阳铨. All rights reserved.
//

#import "HMTRecommendScrollView.h"
#import "HMTRecommendScrollBottomView.h"
#import "HMTRecommendScrollBottomViewModel.h"

static NSInteger const kTimeInterval = 3;

@interface HMTRecommendScrollView ()<UIScrollViewDelegate>

@end

@implementation HMTRecommendScrollView{
    UIScrollView *_scrollView;
    HMTRecommendScrollBottomView *_bottomView;
    NSTimer *_timer;
    NSArray *_models;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    CGRect f = frame;
    f.size.height = kHMTRecommendScrollViewHeight;
    f.size.width = MainScreenWidth;
    self = [super initWithFrame:f];
    if (self) {
        //设置视图
        [self setUpViews];
    }
    return self;
}

-(void)dealloc{
    [_timer invalidate];
    _timer = nil;

}

- (void)setUpViews{
   
    
    
    //scrollView
    UIScrollView *view = [[UIScrollView alloc] init];
    _scrollView = view;
    _scrollView.frame = self.bounds;
    
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scrollView];
    
   
    
    
    
}

-(void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    for (int i = 0; i<imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
#warning TODO 使用框架获取网络图片
        imageView.image = i%2 ? [UIImage imageNamed:@"scrollView1"] : [UIImage imageNamed:@"scrollView2"];
        if (i == 0) {
            imageView.image = [UIImage imageNamed:@"scrollView0"];
        }
        CGFloat imageViewx = MainScreenWidth * i;
        CGFloat imageViewy = 0;
        CGFloat imageVieww = MainScreenWidth;
        CGFloat imageViewh = kHMTRecommendScrollViewHeight;
        imageView.frame = CGRectMake(imageViewx, imageViewy, imageVieww, imageViewh);
        [_scrollView addSubview:imageView];
    }
    //定时器
//    _timer = [NSTimer scheduledTimerWithTimeInterval:kTimeInterval target:self selector:@selector(scrollViewRun) userInfo:nil repeats:YES];
	_timer = [NSTimer timerWithTimeInterval:kTimeInterval target:self selector:@selector(scrollViewRun) userInfo:nil repeats:YES];
    _scrollView.contentSize = CGSizeMake(MainScreenWidth * self.imageArr.count, kHMTRecommendScrollViewHeight);
	[[NSRunLoop currentRunLoop] addTimer:_timer forMode:@"NSDefaultRunLoopMode"];
    //页面指示
    //models
//    NSMutableArray *array = [NSMutableArray array];
//    for (int i = 0; i<self.imageArr.count; i++) {
//        HMTRecommendScrollBottomViewModel *model = [[HMTRecommendScrollBottomViewModel alloc] init];
//        model.title = [NSString stringWithFormat:@"第%d张图的标题",i];
//        [array addObject:model];
//    }
//    _models = array;
    
    //bottomView
    if (self.imageArr.count > 0) {
        
        HMTRecommendScrollBottomView *bottomView = [[HMTRecommendScrollBottomView alloc] initWithFrame:CGRectMake(0, kHMTRecommendScrollViewHeight - kHMTRecommendScrollBottomViewHeight, 0, 0)];
        _bottomView = bottomView;
        _bottomView.models = self.imageArr;
        [self addSubview:_bottomView];
    }
    
}

- (void)scrollViewRun{
    CGPoint offset = _scrollView.contentOffset;
    if (offset.x < MainScreenWidth * (self.imageArr.count - 1)) {
        offset.x += MainScreenWidth;
    }else{
        offset.x = 0;
    }
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        _scrollView.contentOffset = offset;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -----UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.frame.size.width;
    _bottomView.page = (int)(page + 0.5);  //四舍五入计算出页码
}

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    //暂停定时器
//    [_timer setFireDate:[NSDate distantFuture]];
//}
//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    //3秒后开始定时器
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [_timer setFireDate:[NSDate date]];
//    });
//    
//}
@end
