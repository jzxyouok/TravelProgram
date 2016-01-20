//
//  AreaTravelEnterViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/18.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaTravelEnterViewController.h"
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "Home_TravelContent.h"
#import "User_Model.h"
#import "AreaEnterModel.h"
#import "Home_TravelCell.h"
#import "CustomerNetworking.h"
#import "AFNetworking.h"
#import "SingleStaues.h"
#import <MJRefresh.h>
#import "MBProgressHUD.h"
#import "ErrorNetWorkLabel.h"
#import "AreaEnterNavigationBar.h"
#import "TravelDetailViewController.h"
@interface AreaTravelEnterViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
@property (nonatomic,retain)AreaEnterNavigationBar *customBar;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *contentArr;
@property (nonatomic,assign)NSInteger pageNumber;
@property (nonatomic,retain)NSMutableArray *autoContentArr;
@property (nonatomic,retain)MBProgressHUD *hub;
@property (nonatomic,retain)UIImageView *placeImageView;
@end

@implementation AreaTravelEnterViewController
- (void)dealloc
{
    [_content release];
    [_customBar release];
    [_autoContentArr release];
    [_placeImageView release];
    [_hub release];
    [_contentArr release];
    [_tableView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建TableView
    [self createTableView];
    //获取本地存储后再网络数据解析
    //创建Hub
    [self createHub];
    //创建自定义NavBar
    [self createCustomBar];
    //数据解析
    [self getDataSourse];
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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, kWidth, kHeight - 44) style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setDataSource:self];
    [self createRefresh];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    [_tableView release];
}
//数据解析
- (void)getDataSourse{
    //首先从本地获取数据
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *areaTravelEnterContent = [diaryInfo stringByAppendingPathComponent:[NSString stringWithFormat: @"areaTravelEnterContent%@.plist",_content.name_zh_cn]];
    NSArray *getMyData = [NSArray arrayWithContentsOfFile:areaTravelEnterContent];
    if (getMyData) {
        [self aftetGetContentArray:getMyData];
    } else {
        if ([[SingleStaues shareNetStatus]statues]) {
            NSString *searchWord = [_content.name_zh_cn stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/search/trips.json?q=%@&page=1",searchWord] andParameters:nil andBlock:^(id responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSArray *getArray = responseObject;
                [getArray writeToFile:areaTravelEnterContent atomically:YES];
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
    NSString *areaTravelEnterContent = [diaryInfo stringByAppendingPathComponent:[NSString stringWithFormat: @"areaTravelEnterContent%@.plist",_content.name_zh_cn]];
    if ([[SingleStaues shareNetStatus]statues]) {
        NSString *searchWord = [_content.name_zh_cn stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/search/trips.json?q=%@&page=1",searchWord] andParameters:nil andBlock:^(id responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSArray *getArray = responseObject;
            [[NSFileManager defaultManager] removeItemAtPath:areaTravelEnterContent error:nil];
            [getArray writeToFile:areaTravelEnterContent atomically:YES];
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
        NSString *searchWord = [_content.name_zh_cn stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/search/trips.json?q=%@&page=%ld",searchWord,(long)self.pageNumber] andParameters:nil andBlock:^(id responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSArray *getArray = responseObject;
            [self aftetGetContentArray:getArray];
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
    return 10 * self.pageNumber;
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
//创建自定义bar
- (void)createCustomBar{
    self.customBar = [[AreaEnterNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.customBar.titleView setText:[NSString stringWithFormat:@"%@|游记",_content.name_zh_cn]];
    [self.customBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customBar];
    [_customBar release];
}
- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
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
@end
