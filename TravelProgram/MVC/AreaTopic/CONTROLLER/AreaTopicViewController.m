//
//  AreaTopicViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/15.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "AreaTopicViewController.h"
#import "AreaEnterNavigationBar.h"
#import "AreaEnterModel.h"
#import "CustomerNetworking.h"
#import "AFNetworking.h"
#import "SingleStaues.h"
#import "Topic_Cell.h"
#import <MJRefresh.h>
#import "MBProgressHUD.h"
#import "Topic_DetailViewController.h"
#import "ErrorNetWorkLabel.h"
#import "Topic_Content.h"
@interface AreaTopicViewController ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
@property (nonatomic,retain)AreaEnterNavigationBar *customBar;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *contentArr;
@property (nonatomic,retain)MBProgressHUD *hub;
@property (nonatomic,retain)UIImageView *placeImageView;
@end

@implementation AreaTopicViewController
- (void)dealloc
{
    [_content release];
    [_placeImageView release];
    [_hub release];
    [_customBar release];
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
    //创建自定义NavBar
    [self createCustomBar];
    //数据解析
    [self getDataSourse];
}
//创建TableView
- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, kWidth, kHeight - 44) style:UITableViewStylePlain];
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    [self.tableView setDelegate:self];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setDataSource:self];
    [self createRefresh];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    [_tableView release];
}
//创建上拉刷新
- (void)createRefresh{
    [self.tableView setHeader:[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self upRefresh];
    }]];
}
- (void)upRefresh{
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *areaTopicPageContent = [diaryInfo stringByAppendingPathComponent:[NSString stringWithFormat:@"areaTopicPageContent%@.plist",self.content.ID]];
    if ([[SingleStaues shareNetStatus]statues]) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/articles.json?destination_id=%@&page=1",self.content.ID]andParameters:nil andBlock:^(id responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [[NSFileManager defaultManager] removeItemAtPath:areaTopicPageContent error:nil];
            [NSKeyedArchiver archiveRootObject:responseObject toFile:areaTopicPageContent];
            [self.contentArr removeAllObjects];
            [self aftetGetContentArray:responseObject];
        } andErrorBlock:^(NSError *error) {
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArr.count ? self.contentArr.count : 0;
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
//数据解析
- (void)getDataSourse{
    //首先从本地获取数据
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *areaTopicPageContent = [diaryInfo stringByAppendingPathComponent:[NSString stringWithFormat:@"areaTopicPageContent%@.plist",self.content.ID]];
    NSArray *getMyData = [NSKeyedUnarchiver unarchiveObjectWithFile:areaTopicPageContent];
    if (getMyData) {
        [self aftetGetContentArray:getMyData];
    } else {
        if ([[SingleStaues shareNetStatus]statues]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/articles.json?destination_id=%@&page=1",self.content.ID]andParameters:nil andBlock:^(id responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [NSKeyedArchiver archiveRootObject:responseObject toFile:areaTopicPageContent];
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
//创建自定义bar
- (void)createCustomBar{
    self.customBar = [[AreaEnterNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.customBar.titleView setText:[NSString stringWithFormat:@"%@|专题",_content.name_zh_cn]];
    [self.customBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customBar];
    [_customBar release];
}
- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
