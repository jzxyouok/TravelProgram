//
//  ShowPicView.m
//  轮播图
//
//  Created by 付寒宇 on 15/9/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "ShowPicView.h"
#import "MyImageView.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#define kWidth self.scrollViewFrame.size.width
#define kHeight self.scrollViewFrame.size.height
@interface ShowPicView ()<UIScrollViewDelegate,MyImageViewDelegate>

@property (nonatomic,strong)NSMutableArray *picArray;
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,assign)CGFloat timeInterval;
@property (nonatomic,assign)NSInteger picNumber;
@property (nonatomic,assign)CGRect scrollViewFrame;
@property (nonatomic,strong)UIPageControl *pageControl;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)NSTimer *laterTimer;
@end

@implementation ShowPicView
- (void)dealloc
{
    [_picArray release];
    [_scrollView release];
    [_pageControl release];
    [_timer release];
    [_laterTimer release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame andPicUrlStringArray:(NSArray *)picArray andTimeInterval:(CGFloat)timeInterval{
    self = [super initWithFrame:frame];
    if (self) {
        //新的照片数组建立
        [self setUserInteractionEnabled:YES];
        self.picArray = [NSMutableArray arrayWithObject:picArray[picArray.count - 1]];
        for (int i = 0 ; i < picArray.count; i++) {
            [self.picArray addObject:picArray[i]];
        }
        [self.picArray addObject:picArray[0]];
        //照片数量
        self.picNumber = self.picArray.count;
        self.scrollViewFrame = frame;
        self.timeInterval = timeInterval;

#pragma mark scrollView
        
        [self createScrollView];

        
#pragma mark PageController
        
        [self createPageController];

#pragma mark 计时器
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(changePage) userInfo:nil repeats:YES];
        
    }
    return self;
}

- (void)createScrollView{

    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.scrollView setUserInteractionEnabled:YES];
    [self.scrollView setScrollsToTop:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setDelegate:self];
    [self.scrollView setContentSize:CGSizeMake(kWidth * self.picNumber, kHeight)];
    [self.scrollView setContentOffset:CGPointMake(kWidth, 0)];
    [self.scrollView setPagingEnabled:YES];
    [self addSubview:self.scrollView];
    //加载图片
    for (int i = 0 ; i < self.picNumber; i ++) {
        MyImageView *pic = [[MyImageView alloc]initWithFrame:CGRectMake(i * kWidth, 0, kWidth, kHeight)];
        [pic setDelegate:self];
        pic.content = self.picArray[i];
        [self.scrollView addSubview:pic];
    }
}

- (void)createPageController{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kHeight - 25, kWidth / 3, 9)];
    [self.pageControl setPageIndicatorTintColor:[UIColor redColor]];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [self.pageControl setTintColor:[UIColor blackColor]];
    [self.pageControl setNumberOfPages:self.picArray.count - 2];
    [self.pageControl addTarget:self action:@selector(changePic:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.pageControl];
}
- (void)touchBegin{
    [self.timer setFireDate:[NSDate distantFuture]];
    [self.laterTimer setFireDate:[NSDate distantFuture]];
}


- (void)touchLeft{
    self.laterTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(begin) userInfo:nil repeats:NO];
    self.clickBlock(self.pageControl.currentPage);
}

- (void)begin{
    [self.timer setFireDate:[NSDate distantPast]];
}

#pragma mark PageController事件
- (void)changePic:(UIPageControl *)pageController{
    NSInteger number = pageController.currentPage;
    [self.scrollView setContentOffset:CGPointMake(self.scrollViewFrame.size.width * (number + 1), 0)];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self touchBegin];
}


#pragma mark UIScrollView的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.laterTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(begin) userInfo:nil repeats:NO];
    NSInteger pageNumber = (scrollView.contentOffset.x / self.scrollViewFrame.size.width) - 1;
    if (pageNumber > self.picNumber - 3) {
        [self.pageControl setCurrentPage:0];
        [self.scrollView setContentOffset:CGPointMake(self.scrollViewFrame.size.width, 0)];
    }else if (pageNumber < 0){
        
        [self.pageControl setCurrentPage:self.picNumber - 3];
        [self.scrollView setContentOffset:CGPointMake(self.scrollViewFrame.size.width * (self.picNumber - 2), 0)];
    }else{
        [self.pageControl setCurrentPage:pageNumber];
        [self.scrollView setContentOffset:CGPointMake(self.scrollViewFrame.size.width * (pageNumber + 1), 0)];
    }

}
    
- (void)changePage{
    if (self.pageControl.currentPage < self.picNumber - 3) {
        self.pageControl.currentPage++;
        [self.scrollView setContentOffset:CGPointMake(self.scrollViewFrame.size.width * (self.pageControl.currentPage + 1), 0) animated:YES];
        } else {
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
        [self.pageControl setCurrentPage:0];
        [self.scrollView setContentOffset:CGPointMake(self.scrollViewFrame.size.width, 0) animated:YES];
    }
}
- (void)clickBlock:(clickPic)clickBlock{
    _clickBlock = [clickBlock copy];
}

@end
