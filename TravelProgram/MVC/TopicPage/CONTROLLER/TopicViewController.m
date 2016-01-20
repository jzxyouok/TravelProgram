//
//  TopicViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "TopicViewController.h"
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "Topic_Content.h"
#import "CustomerNetworking.h"
#import "AFNetworking.h"
#import "SingleStaues.h"
#import <MJRefresh.h>
#import "Topic_Cell.h"
#import "MBProgressHUD.h"
#import "Topic_DetailViewController.h"
#import "ErrorNetWorkLabel.h"
@interface TopicViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *contentArr;
@property (nonatomic,assign)NSInteger pageNumber;
@property (nonatomic,retain)MBProgressHUD *hub;
@property (nonatomic,retain)UIImageView *placeImageView;

@end

@implementation TopicViewController
- (void)dealloc
{
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
    //创建Hub
    [self createHub];
    //数据解析
    [self getDataSourse];

}
//数据解析
- (void)getDataSourse{
    //首先从本地获取数据
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *topicPageContent = [diaryInfo stringByAppendingPathComponent:@"topicPageContent.plist"];
    NSArray *getMyData = [NSKeyedUnarchiver unarchiveObjectWithFile:topicPageContent];
    if (getMyData) {
        [self aftetGetContentArray:getMyData];
    } else {
        if ([[SingleStaues shareNetStatus]statues]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [CustomerNetworking connectWithURLString:@"https://chanyouji.com/api/articles.json?page=1" andParameters:nil andBlock:^(id responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [NSKeyedArchiver archiveRootObject:responseObject toFile:topicPageContent];
                [self aftetGetContentArray:responseObject];
            } andErrorBlock:^(NSError *error) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSLog(@"有错误出现");
                [self.hub removeFromSuperview];
                [self badNetWork];
            }];
        } else {
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
}
//拿到数据后
- (void)aftetGetContentArray:(NSArray *)array{
    for (NSDictionary *dictionary in array) {
        Topic_Content *oneContent = [[Topic_Content alloc]initWithDictionary:dictionary];
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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, kWidth, kHeight  + 20) style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
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
    NSString *topicPageContent = [diaryInfo stringByAppendingPathComponent:@"topicPageContent.plist"];
    if ([[SingleStaues shareNetStatus]statues]) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [CustomerNetworking connectWithURLString:@"https://chanyouji.com/api/articles.json?page=1" andParameters:nil andBlock:^(id responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSArray *getArray = responseObject;
            [[NSFileManager defaultManager] removeItemAtPath:topicPageContent error:nil];
            [getArray writeToFile:topicPageContent atomically:YES];
            [self.contentArr removeAllObjects];
            [self aftetGetContentArray:getArray];
            [self.tableView.header endRefreshing];
        }andErrorBlock:^(NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSLog(@"有错误出现");
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
        [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/articles.json?page=%ld",(long)self.pageNumber] andParameters:nil andBlock:^(id responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSArray *getArray = responseObject;
            [self aftetGetContentArray:getArray];
            [self.tableView.footer endRefreshing];
        }andErrorBlock:^(NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSLog(@"有错误出现");
            [self.tableView.footer endRefreshing];
            [self badNetWork];
        }];
    } else {
        [self badNetWork];
        [self.tableView.footer endRefreshing];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10 * self.pageNumber;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Topic_Cell *cell = [Topic_Cell topic_CellWithTableView:tableView];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.content = nil;
    if (self.contentArr.count) {
        cell.content = self.contentArr[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHeight / 2.8;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.contentArr.count) {
        Topic_DetailViewController *topic_DetailViewController = [[Topic_DetailViewController alloc]init];
        topic_DetailViewController.topic_Content = self.contentArr[indexPath.row];
        [self.navigationController pushViewController:topic_DetailViewController animated:YES];
        [topic_DetailViewController release];
    }
}
//滑动隐藏Tabbar
static CGFloat topicContentOffSetY = 0;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 100) {
        CGFloat change = topicContentOffSetY - self.tableView.contentOffset.y;
        if(change < - 10){
            [self.navigationController.tabBarController.tabBar setHidden:YES];
            topicContentOffSetY = self.tableView.contentOffset.y;
        }else if (change > 10 ){
            [self.navigationController.tabBarController.tabBar setHidden:NO];
            topicContentOffSetY = self.tableView.contentOffset.y;
        }
    } else {
        [self.navigationController.tabBarController.tabBar setHidden:NO];
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
- (NSInteger)pageNumber{
    if (!_pageNumber) {
        _pageNumber = 1;
    }
    return _pageNumber;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
