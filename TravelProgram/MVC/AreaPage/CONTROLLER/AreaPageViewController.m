//
//  AreaPageViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "AreaPageViewController.h"
#import "CustomNavigationBar_Area.h"
#import "Area_ChinaViewController.h"
#import "Area_StateViewController.h"
#import "CustomerNetworking.h"
#import "Area_ContentModel.h"
#import "MBProgressHUD.h"
#import "ErrorNetWorkLabel.h"
#import "SingleStaues.h"
#import "SearchViewController.h"
#import "MyPageViewController.h"
@interface AreaPageViewController ()<UIScrollViewDelegate,MBProgressHUDDelegate>
@property (nonatomic,retain)UIScrollView *scrollView;
@property (nonatomic,retain)NSMutableArray *chinaContentArr;
@property (nonatomic,retain)NSMutableArray *stateContentArr;
@property (nonatomic,retain)Area_ChinaViewController *chinaViewController;
@property (nonatomic,retain)Area_StateViewController *stateViewController;
@property (nonatomic,retain)MBProgressHUD *hub;
@property (nonatomic,retain)UIImageView *placeImageView;
@property (nonatomic,assign)BOOL netWorkBad;
@end

@implementation AreaPageViewController
- (void)dealloc
{
    [_placeImageView release];
    [_hub release];
    [_stateViewController release];
    [_stateContentArr release];
    [_chinaViewController release];
    [_chinaContentArr release];
    [_scrollView release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated{
    if (_netWorkBad) {
        [self getDataSourse];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加两个子视图控制器 并且把view添加在ScrollView上
    [self addChildViewControllers];
    //创建Hub
    [self createHub];
    //网络数据解析
    [self getDataSourse];
    //增加左右清扫手势
    [self addSwipeGesture];
}
//网络数据解析
- (void)getDataSourse{
    //首先从本地获取数据
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *areaPageContent = [diaryInfo stringByAppendingPathComponent:@"areaPageContent.plist"];
    NSArray *getMyData = [NSArray arrayWithContentsOfFile:areaPageContent];
    if (getMyData) {
        [self aftetGetContentArray:getMyData];
        if ([[SingleStaues shareNetStatus]statues]) {
            self.netWorkBad = NO;
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [CustomerNetworking connectWithURLString:@"https://chanyouji.com/api/destinations.json?page=1" andParameters:nil andBlock:^(id responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSArray *getArray = responseObject;
                [[NSFileManager defaultManager] removeItemAtPath:areaPageContent error:nil];
                [getArray writeToFile:areaPageContent atomically:YES];
            }andErrorBlock:^(NSError *error) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSLog(@"有错误出现");
                [self badNetWork];
                [self.hub removeFromSuperview];
            }];
        } else {
            [self.hub removeFromSuperview];
            [self badNetWork];
        }
    } else {
        if ([[SingleStaues shareNetStatus]statues]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [CustomerNetworking connectWithURLString:@"https://chanyouji.com/api/destinations.json?page=1" andParameters:nil andBlock:^(id responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSArray *getArray = responseObject;
                [getArray writeToFile:areaPageContent atomically:YES];
                [self aftetGetContentArray:getArray];
            }andErrorBlock:^(NSError *error) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSLog(@"有错误出现");
                [self.hub removeFromSuperview];
                [self badNetWork];
            }];
        } else {
            [self.hub removeFromSuperview];
            [self badNetWork];
        }
    }
}
//淡入提示网络问题Label
- (void)badNetWork{
    self.netWorkBad = YES;
    ErrorNetWorkLabel *errorLabel = [[ErrorNetWorkLabel alloc]initWithFrame:CGRectMake(kWidth / 2 - 120, kHeight / 2 - 15, 240, 30)];
    [errorLabel setTag:9999];
    errorLabel.alpha = 0;
    [self.view addSubview:errorLabel];
    [UIView animateWithDuration:1 animations:^{
        [errorLabel setAlpha:1];
    } completion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeErrorLabel) userInfo:nil repeats:NO];
    }];
}
- (void)removeErrorLabel{
    [[self.view viewWithTag:9999] removeFromSuperview];
}
//拿到首页内容数据后执行数据写入视图中
- (void)aftetGetContentArray:(NSArray *)array{
    for (int i = 0; i < 5; i++) {
        NSDictionary *dictionary = array[i];
        Area_ContentModel *oneContent = [[Area_ContentModel alloc]initWithDictionary:dictionary];
        if (i < 3) {
            [self.stateContentArr addObject:oneContent];
        } else {
            [self.chinaContentArr addObject:oneContent];
        }
        [oneContent release];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.chinaViewController setContentArray:self.chinaContentArr];
        [self.chinaViewController.collectionView reloadData];
        [self.stateViewController setContentArray:self.stateContentArr];
        [self.stateViewController.collectionView reloadData];
        [self.hub removeFromSuperview];
        [self.placeImageView removeFromSuperview];
    });
}


- (void)addChildViewControllers{
    self.stateViewController = [[Area_StateViewController alloc]init];
    [self.stateViewController.view setFrame:CGRectMake(0, 0, kWidth, self.scrollView.frame.size.height)];
    [self.scrollView addSubview:self.stateViewController.view];
    [self.stateViewController.view release];
    [self addChildViewController:self.stateViewController];
    [_stateViewController release];
    self.chinaViewController = [[Area_ChinaViewController alloc]init];
    [self.chinaViewController.view setFrame:CGRectMake(kWidth, 0, kWidth, self.scrollView.frame.size.height)];
    [self.scrollView addSubview:self.chinaViewController.view];
    [self.chinaViewController.view release];
    [self addChildViewController:self.chinaViewController];
    [_chinaViewController release];

}

//搜索的点击事件
- (void)searchAction:(UIButton *)btn{
    [super searchAction:btn];
    SearchViewController *searchViewController = [[SearchViewController alloc]init];
    [searchViewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:searchViewController animated:YES];
    [searchViewController release];
    
}
//China按钮点击事件
- (void)china:(UIButton *)chinaBtn{
    [super china:chinaBtn];
    if (self.scrollView.contentOffset.x == 0) {
        [self.scrollView setContentOffset:CGPointMake(kWidth, 0) animated:YES];
        [self.stateViewController.collectionView setScrollsToTop:YES];
        [self.chinaViewController.collectionView setScrollsToTop:NO];
    }
}
//State按钮点击事件
- (void)state:(UIButton *)otherCountry{
    [super state:otherCountry];
    if (self.scrollView.contentOffset.x == kWidth) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [self.chinaViewController.collectionView setScrollsToTop:YES];
        [self.stateViewController.collectionView setScrollsToTop:NO];
    }
}

- (void)myPage:(UIButton *)myPageBtn{
    MyPageViewController *myPageViewController = [[MyPageViewController alloc]init];
    [self.navigationController pushViewController:myPageViewController animated:YES];
    [myPageViewController release];
}

//滑动到top开关
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        [[self.childViewControllers[1] collectionView] setScrollsToTop:NO];//state
        [[self.childViewControllers[0] collectionView] setScrollsToTop:YES];//china
    }else{
        [[self.childViewControllers[1] collectionView] setScrollsToTop:YES];//state
        [[self.childViewControllers[0] collectionView] setScrollsToTop:NO];//china
    }
}
//添加手势
- (void)addSwipeGesture{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.scrollView addGestureRecognizer:swipeLeft];
    [swipeLeft release];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.scrollView addGestureRecognizer:swipeRight];
    [swipeRight release];
}
- (void)leftSwipe{
    if (self.scrollView.contentOffset.x == 0) {
        [self china:self.customNavigationBar.china];
    }
}
- (void)rightSwipe{
    if (self.scrollView.contentOffset.x == kWidth) {
        [self state:self.customNavigationBar.otherCountry];
    }
}
//懒加载
- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64 - 49)];
        [_scrollView setDelegate:self];
        [_scrollView setContentSize:CGSizeMake(kWidth * 2, kHeight - 64 - 49)];
        [_scrollView setContentOffset:CGPointMake(0, 0)];
        [_scrollView setScrollEnabled:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setBounces:NO];
        [_scrollView setScrollsToTop:NO];
        [self.view addSubview:_scrollView];
        [_scrollView release];
    }
    return _scrollView;
}
//创建HUB
- (void)createHub{
    self.placeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64)];
    self.hub = [MBProgressHUD showHUDAddedTo:self.placeImageView animated:YES];
    [self.hub setDelegate:self];
    [self.placeImageView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.placeImageView];
    [_placeImageView release];
}
- (NSMutableArray *)chinaContentArr{
    if (_chinaContentArr == nil) {
        _chinaContentArr = [[NSMutableArray alloc]init];
    }
    return _chinaContentArr;
}
- (NSMutableArray *)stateContentArr{
    if (_stateContentArr == nil) {
        _stateContentArr = [[NSMutableArray alloc]init];
    }
    return _stateContentArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
