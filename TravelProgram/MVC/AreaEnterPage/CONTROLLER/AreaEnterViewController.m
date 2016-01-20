//
//  AreaEnterViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/13.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "AreaEnterViewController.h"
#import "Area_DestinationsModel.h"
#import "AreaEnter_TableViewCell.h"
#import "AreaEnterNavigationBar.h"
#import "MBProgressHUD.h"
#import "CustomerNetworking.h"
#import "ErrorNetWorkLabel.h"
#import "AreaEnterModel.h"
#import <MJRefresh.h>
#import "SingleStaues.h"
#import "EnterView.h"
#import "AreaTopicViewController.h"
#import "AreaPlansViewController.h"
#import "AreaSiteViewController.h"
#import "AreaTravelEnterViewController.h"
@interface AreaEnterViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate,EnterViewDelegate>
@property (nonatomic,retain)AreaEnterNavigationBar *customBar;
@property (nonatomic,retain)NSMutableArray *contentArray;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)MBProgressHUD *hub;
@property (nonatomic,retain)UIImageView *placeImageView;
@end

@implementation AreaEnterViewController
- (void)dealloc
{
    [_content release];
    [_contentArray release];
    [_tableView release];
    [_customBar release];
    [_hub release];
    [_placeImageView release];
    [super dealloc];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建TableView
    [self createTableView];
    //创建Hub
    [self createHub];
    //创建自定义NavBar
    [self createCustomBar];
    //数据解析
    [self getDateSource];
}
//创建TableView
- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    [self.tableView registerClass:[AreaEnter_TableViewCell class] forCellReuseIdentifier:@"areaEnter_TableViewCell"];
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    [self.tableView setContentInset:UIEdgeInsetsMake(44, 0, 0, 0)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self createRefresh];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    [_tableView release];
}
//创建下拉刷新
- (void)createRefresh{
    [self.tableView setHeader:[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self upRefresh];
    }]];
}
//上拉后实行网络请求
- (void)upRefresh{
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *areaEnterPageContent = [diaryInfo stringByAppendingPathComponent:[NSString stringWithFormat:@"areaEnterPageContent%@.plist",self.content.ID]];
    if ([[SingleStaues shareNetStatus]statues]) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/destinations/%@.json?page=1",self.content.ID] andParameters:nil andBlock:^(id responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSArray *getArray = responseObject;
            [[NSFileManager defaultManager] removeItemAtPath:areaEnterPageContent error:nil];
            [NSKeyedArchiver archiveRootObject:responseObject toFile:areaEnterPageContent];
            [self.contentArray removeAllObjects];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count ? self.contentArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AreaEnter_TableViewCell *cell = [AreaEnter_TableViewCell areaEnter_TableViewCellWithTableView:tableView];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.content = nil;
    if (self.contentArray.count) {
        cell.content = self.contentArray[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHeight / 3;
}
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AreaEnterModel *pushInfo = self.contentArray[indexPath.row];
    UIBlurEffect *style = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    EnterView *enter = [[EnterView alloc]initWithEffect:style];
    [enter setDelegate:self];
    [enter setTag:10000];
    [enter setViewContent:pushInfo];
    [enter setFrame:self.view.frame];
    [enter setAlpha:0];
    [self.view addSubview:enter];
    [UIView animateWithDuration:0.4 animations:^{
        [enter setAlpha:1];
    } completion:^(BOOL finished) {
        [enter starShow];
    }];
}
- (void)pushToPage:(NSInteger)buttonTag andModel:(AreaEnterModel *)content{
    if (buttonTag == 3003) {
        AreaTopicViewController *topic = [[AreaTopicViewController alloc]init];
        topic.content = content;
        [self.navigationController pushViewController:topic animated:YES];
        [topic release];
    } else if (buttonTag == 3000){
        AreaPlansViewController *plans = [[AreaPlansViewController alloc]init];
        plans.content = content;
        [self.navigationController pushViewController:plans animated:YES];
        [plans release];
    } else if (buttonTag == 3002){
        AreaSiteViewController *site = [[AreaSiteViewController alloc]init];
        site.content = content;
        [self.navigationController pushViewController:site animated:YES];
        [site release];
    } else{
        AreaTravelEnterViewController *travel = [[AreaTravelEnterViewController alloc]init];
        travel.content = content;
        [self.navigationController pushViewController:travel animated:YES];
        [travel release];
    }
}
//滑动隐藏CustomBar
static CGFloat areaEnterContentOffSetY = 0;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 100) {
        CGFloat change = areaEnterContentOffSetY - self.tableView.contentOffset.y;
        if(change < - 10){
            [self.customBar setHidden:YES];
            areaEnterContentOffSetY = self.tableView.contentOffset.y;
        }else if (change > 10 ){
            [self.customBar setHidden:NO];
            areaEnterContentOffSetY = self.tableView.contentOffset.y;
        }
    } else {
        [self.customBar setHidden:NO];
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
//创建自定义bar
- (void)createCustomBar{
    self.customBar = [[AreaEnterNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.customBar.titleView setText:_content.name_zh_cn];
    [self.customBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customBar];
    [_customBar release];
}
- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//请求数据
- (void)getDateSource{
    //首先从本地获取数据
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *areaEnterPageContent = [diaryInfo stringByAppendingPathComponent:[NSString stringWithFormat:@"areaEnterPageContent%@.plist",self.content.ID]];
    NSArray *getMyData = [NSKeyedUnarchiver unarchiveObjectWithFile:areaEnterPageContent];
    if (getMyData) {
        [self aftetGetContentArray:getMyData];
    } else {
        if ([[SingleStaues shareNetStatus] statues]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/destinations/%@.json?page=1",self.content.ID] andParameters:nil andBlock:^(id responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSArray *getArray = responseObject;
                [NSKeyedArchiver archiveRootObject:responseObject toFile:areaEnterPageContent];
                [self aftetGetContentArray:getArray];
            }andErrorBlock:^(NSError *error) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSLog(@"网络错误");
                [self.hub removeFromSuperview];
                [self badNetWork];
            }];
        }else{
            [self badNetWork];
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
}
//拿到数据后
- (void)aftetGetContentArray:(NSArray *)array{
    self.contentArray = [NSMutableArray array];
    for (NSDictionary *areaEnterDic in array) {
        AreaEnterModel *areaEnterOne = [[AreaEnterModel alloc]initWithDictionary:areaEnterDic];
        [self.contentArray addObject:areaEnterOne];
        [areaEnterOne release];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.hub removeFromSuperview];
        [self.placeImageView removeFromSuperview];
    });
}

@end