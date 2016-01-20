//
//  HomePageViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "HomePageViewController.h"
#import "Home_TravelContent.h"
#import "User_Model.h"
#import "Home_TravelCell.h"
#import "CustomerNetworking.h"
#import "AFNetworking.h"
#import "SingleStaues.h"
#import <MJRefresh.h>
#import "ShowPicView.h"
#import "MBProgressHUD.h"
#import "ErrorNetWorkLabel.h"
#import "TravelDetailViewController.h"
#import "EAIntroView.h"
#import "DataBaseHandle.h"
@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,EAIntroDelegate>
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *contentArr;
@property (nonatomic,assign)NSInteger pageNumber;
@property (nonatomic,retain)ShowPicView *autoScrollPic;
@property (nonatomic,retain)NSMutableArray *autoContentArr;
@property (nonatomic,retain)MBProgressHUD *hub;
@property (nonatomic,retain)UIImageView *placeImageView;
@property (nonatomic,assign)BOOL netWorkBad;
@end
@implementation HomePageViewController
- (void)dealloc
{
    [_placeImageView release];
    [_hub release];
    [_contentArr release];
    [_autoScrollPic release];
    [_tableView release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated{
    if (_netWorkBad) {
        [self getAutoScrollPicData];
        [self upRefresh];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  进行数据库的操作
     */
    [[DataBaseHandle shareDataBaseHandle]openDB];
    [[DataBaseHandle shareDataBaseHandle]createTravelTable];
    [[DataBaseHandle shareDataBaseHandle]createTopicTable];
    [[DataBaseHandle shareDataBaseHandle]createPlanlTable];
    [[DataBaseHandle shareDataBaseHandle]createSiteTable];

    //创建TableView
    [self createTableView];
    //获取本地存储后再网络数据解析
    //循环滚动视图数据解析
    [self getAutoScrollPicData];
    //创建Hub
    [self createHub];
    //数据解析
    [self getDataSourse];
    /**
     *  引导页是否展示
     */
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"firstLoad"]) {
        [self showIntroWithCrossDissolve];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLoad"];
    }
}
//循环滚动视图数据解析
- (void)getAutoScrollPicData{
    //首先从本地获取数据
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *homePageAutoPic = [diaryInfo stringByAppendingPathComponent:@"homePageAutoPic.plist"];
    NSArray *getMyData = [NSArray arrayWithContentsOfFile:homePageAutoPic];
    if (getMyData) {//本地有数据优先使用本地数据
        [self afterGetDate:getMyData];
        if ([[SingleStaues shareNetStatus]statues]) {
            [CustomerNetworking connectWithURLString:@"https://chanyouji.com/api/trips/featured.json?page=100" andParameters:nil andBlock:^(id responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSArray *getArray = responseObject;
                [getArray writeToFile:homePageAutoPic atomically:YES];
            }andErrorBlock:^(NSError *error) {
                [self badNetWork];
            }];
        } 
    } else {//没有数据网络请求
        if ([[SingleStaues shareNetStatus]statues]) {
            [CustomerNetworking connectWithURLString:@"https://chanyouji.com/api/trips/featured.json?page=100" andParameters:nil andBlock:^(id responseObject) {
                NSArray *getArray = responseObject;
                [getArray writeToFile:homePageAutoPic atomically:YES];
                [self afterGetDate:getArray];
            }andErrorBlock:^(NSError *error) {
                [self badNetWork];
            }];
        } else {
            self.netWorkBad = YES;
            [self badNetWork];
            [self.hub removeFromSuperview];
        }
    }
}
//淡入提示网络问题Label
- (void)badNetWork{
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
}//那到数据后把轮播图写入视图(未设刷新)
- (void)afterGetDate:(NSArray *)getArray{
    self.netWorkBad = NO;
    for (int i = 0 ;i < 5 ;i++) {
        NSDictionary *dictionary = getArray[i];
        Home_TravelContent *oneContent = [[Home_TravelContent alloc]initWithDictionary:dictionary];
        [self.autoContentArr addObject:oneContent];
        [oneContent release];
    }
    self.autoScrollPic = [[ShowPicView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight / 3) andPicUrlStringArray:self.autoContentArr andTimeInterval:4];
    self.tableView.tableHeaderView = self.autoScrollPic;
    //轮播图点击事件
    [self.autoScrollPic clickBlock:^(NSInteger number) {
        TravelDetailViewController *travelDetailViewController = [[TravelDetailViewController alloc]init];
        Home_TravelContent *temp = self.autoContentArr[number];
        travelDetailViewController.titileContent = temp;
        [self.navigationController pushViewController:travelDetailViewController animated:YES];
        [travelDetailViewController release];
    }];
}
//数据解析
- (void)getDataSourse{
    //首先从本地获取数据
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *homePageContent = [diaryInfo stringByAppendingPathComponent:@"homePageContent.plist"];
    NSArray *getMyData = [NSArray arrayWithContentsOfFile:homePageContent];
    if (getMyData) {
        [self aftetGetContentArray:getMyData];
    } else {
        if ([[SingleStaues shareNetStatus]statues]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [CustomerNetworking connectWithURLString:@"https://chanyouji.com/api/trips/featured.json?page=1" andParameters:nil andBlock:^(id responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSArray *getArray = responseObject;
                [getArray writeToFile:homePageContent atomically:YES];
                [self aftetGetContentArray:getArray];
            }andErrorBlock:^(NSError *error) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [self.hub removeFromSuperview];
                [self badNetWork];
            }];
        } else {
            [self badNetWork];
            [self.hub removeFromSuperview];
        }
    }
}
//拿到首页内容数据后执行数据写入视图中
- (void)aftetGetContentArray:(NSArray *)array{
    for (NSDictionary *dictionary in array) {
        Home_TravelContent *oneContent = [[Home_TravelContent alloc]initWithDictionary:dictionary];
        [self.contentArr addObject:oneContent];
        [oneContent release];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.hub removeFromSuperview];
        [self.placeImageView removeFromSuperview];
    });
}
//创建TableView
- (void)createTableView{
    UIImageView *placeAutoPic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight / 3)];
    [placeAutoPic setImage:[UIImage imageNamed:@"placeHoder"]];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, kWidth, kHeight  + 20) style:UITableViewStylePlain];
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setTableHeaderView:placeAutoPic];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self createRefresh];
    [self.view addSubview:self.tableView];
    [_tableView release];
}
//创建上拉刷新下拉加载
- (void)createRefresh{
    [self.tableView setHeader:[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self upRefresh];
    }]];
    [self.tableView setFooter:[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNumber++;
        [self downRefresh];
    }]];
}
//上拉后实行网络请求
- (void)upRefresh{
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *homePageContent = [diaryInfo stringByAppendingPathComponent:@"homePageContent.plist"];
    if ([[SingleStaues shareNetStatus]statues]) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [CustomerNetworking connectWithURLString:@"https://chanyouji.com/api/trips/featured.json?page=1" andParameters:nil andBlock:^(id responseObject) {
            NSArray *getArray = responseObject;
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [[NSFileManager defaultManager] removeItemAtPath:homePageContent error:nil];
            [getArray writeToFile:homePageContent atomically:YES];
            [self.contentArr removeAllObjects];
            [self aftetGetContentArray:getArray];
            [self.tableView.header endRefreshing];
        }andErrorBlock:^(NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self.tableView.header endRefreshing];
            [self badNetWork];
        }];
    } else {
        [self badNetWork];
        [self.tableView.header endRefreshing];
    }
}
//下拉后实行网络请求
- (void)downRefresh{
    if ([[SingleStaues shareNetStatus]statues]) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/trips/featured.json?page=%ld",(long)self.pageNumber] andParameters:nil andBlock:^(id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSArray *getArray = responseObject;
            [self aftetGetContentArray:getArray];
            [self.tableView.footer endRefreshing];
        }andErrorBlock:^(NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self.tableView.footer endRefreshing];
            [self badNetWork];
        }];
    } else {
        [self.tableView.footer endRefreshing];
        [self badNetWork];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _contentArr.count;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Home_TravelCell *cell = [Home_TravelCell Home_TravelCellWithTableView:tableView];
    cell.content = nil;
    if (self.contentArr.count) {
        cell.content = self.contentArr[indexPath.row];
    }
    return cell;
}
//每个cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHeight / 2.8;
}
//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TravelDetailViewController *travelDetailViewController = [[TravelDetailViewController alloc]init];
    if (self.contentArr.count) {
        Home_TravelContent *temp = self.contentArr[indexPath.row];
        travelDetailViewController.titileContent = temp;
        [self.navigationController pushViewController:travelDetailViewController animated:YES];
        [travelDetailViewController release];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//滑动隐藏Tabbar
static CGFloat homeContentOffSetY = 0;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 100) {
        CGFloat change = homeContentOffSetY - self.tableView.contentOffset.y;
        if(change < - 10){
            [self.navigationController.tabBarController.tabBar setHidden:YES];
            homeContentOffSetY = self.tableView.contentOffset.y;
        }else if (change > 10 ){
            [self.navigationController.tabBarController.tabBar setHidden:NO];
            homeContentOffSetY = self.tableView.contentOffset.y;
        }
    }
}
//创建HUB
- (void)createHub{
    self.hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.hub setDelegate:self];
    self.placeImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.placeImageView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:self.placeImageView];
    [_placeImageView release];
}

//懒加载
- (NSMutableArray *)contentArr{
    if (_contentArr == nil) {
        _contentArr = [[NSMutableArray alloc]init];
    }
    return _contentArr;
}
- (NSMutableArray *)autoContentArr{
    if (_autoContentArr == nil) {
        _autoContentArr = [[NSMutableArray alloc] init];
    }
    return _autoContentArr;
}
- (NSInteger)pageNumber{
    if (!_pageNumber) {
        _pageNumber = 1;
    }
    return _pageNumber;
}
- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"曾经我们很小,世界也很小";
    page1.titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    page1.desc = @"                       那时的我们曾感觉,“家门前”就是整个世界";
    page1.descFont = [UIFont systemFontOfSize:14];
    page1.bgImage = [UIImage imageNamed:@"yindao_1"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"现在我们长大，世界也长大";
    page2.titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    page2.desc = @"                                 我想去每个人的“家门前”去看看";
    page2.descFont = [UIFont systemFontOfSize:14];
    page2.bgImage = [UIImage imageNamed:@"yindao_2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"行者日记";
    page3.titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:24];
    page3.desc = @"                               帮你把整个世界拉到你的“家门前”";
    page3.descFont = [UIFont systemFontOfSize:14];
    page3.bgImage = [UIImage imageNamed:@"yindao_3"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3]];
    [intro setTag:1000];
    
    [intro setDelegate:self];
    [intro showInView:[[UIApplication sharedApplication] keyWindow]  animateDuration:0.0];
}
- (void)introDidFinish{
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(removeIntroView) userInfo:nil repeats:NO];
}
- (void)removeIntroView{
    [[self.view viewWithTag:1000] removeFromSuperview];
}
@end
