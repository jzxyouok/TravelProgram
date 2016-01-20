//
//  SearchResultView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "SearchResultView.h"
#import "IDTravelViewController.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
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
#import "TravelDetailViewController.h"
@interface SearchResultView ()<UITableViewDataSource,UITableViewDelegate,MBProgressHUDDelegate>
@property (nonatomic,retain)NSMutableArray *contentArr;
@property (nonatomic,assign)NSInteger pageNumber;
@property (nonatomic,retain)MBProgressHUD *hub;
@property (nonatomic,retain)UIImageView *placeImageView;
@end
@implementation SearchResultView
- (void)dealloc
{
    [_searchWord release];
    [_placeImageView release];
    [_hub release];
    [_contentArr release];
    [_tableView release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        [self.tableView setBackgroundColor:[UIColor blackColor]];
        [self.tableView setDelegate:self];
        [self.tableView setShowsHorizontalScrollIndicator:NO];
        [self.tableView setShowsVerticalScrollIndicator:NO];
        [self.tableView setDataSource:self];
        [self createRefresh];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self addSubview:self.tableView];
        [_tableView release];
    }
    return self;
}
- (void)setSearchWord:(NSString *)searchWord{
    if (_searchWord != searchWord) {
        [_searchWord release];
        _searchWord = [searchWord copy];
        [_contentArr removeAllObjects];
        //创建Hub
        [self createHub];
        //数据解析
        [self getDataSourse];
    }
}
//数据解析
- (void)getDataSourse{
    if ([[SingleStaues shareNetStatus]statues]) {
        NSString *searchWord = [_searchWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/search/trips.json?q=%@&page=1",searchWord] andParameters:nil andBlock:^(id responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSArray *getArray = responseObject;
            [self aftetGetContentArray:getArray];
        }andErrorBlock:^(NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self.hub removeFromSuperview];
            [self badNetWork];
        }];
    }else {
        [self badNetWork];
        [self.hub removeFromSuperview];
    }
}
//淡入提示网络问题Label
- (void)badNetWork{
    ErrorNetWorkLabel *errorLabel = [[ErrorNetWorkLabel alloc]initWithFrame:CGRectMake(kWidth / 2 - 120, kHeight / 2 - 15, 240, 30)];
    [errorLabel setTag:9999];
    errorLabel.alpha = 0;
    [self addSubview:errorLabel];
    [UIView animateWithDuration:1 animations:^{
        [errorLabel setAlpha:1];
    } completion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeErrorLabel) userInfo:nil repeats:NO];
    }];
}
- (void)removeErrorLabel{
    [[self viewWithTag:9999] removeFromSuperview];
}
//拿到首页内容数据后执行数据写入视图中
- (void)aftetGetContentArray:(NSArray *)array{
    for (NSDictionary *dictionary in array) {
        Home_TravelContent *oneContent = [[Home_TravelContent alloc]initWithDictionary:dictionary];
        [self.contentArr addObject:oneContent];
        [oneContent release];
    }
    if (!_contentArr.count) {
        [self noResult];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.hub removeFromSuperview];
        [self.placeImageView removeFromSuperview];
    });
}
//淡入提示网络问题Label
- (void)noResult{
    ErrorNetWorkLabel *noResultLabel = [[ErrorNetWorkLabel alloc]initWithFrame:CGRectMake(kWidth / 2 - 120, kHeight / 2 - 15, 240, 30)];
    [noResultLabel.errorLabel setText:@"您搜索的内容不存在,请尝试其他关键字"];
    [noResultLabel setTag:99999];
    noResultLabel.alpha = 0;
    [self addSubview:noResultLabel];
    [UIView animateWithDuration:1 animations:^{
        [noResultLabel setAlpha:1];
    } completion:^(BOOL finished) {
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeNoResultLabel) userInfo:nil repeats:NO];
    }];
}
- (void)removeNoResultLabel{
    [[self viewWithTag:99999] removeFromSuperview];
}
//创建下拉加载
- (void)createRefresh{
    [self.tableView setFooter:[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNumber++;
        [self downRefresh];
    }]];
}
//下拉后实行网络请求
- (void)downRefresh{
    if ([[SingleStaues shareNetStatus]statues]) {
        NSString *searchWord = [_searchWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/search/trips.json?q=%@&page=%ld",searchWord,(long)self.pageNumber] andParameters:nil andBlock:^(id responseObject) {
            NSArray *getArray = responseObject;
            [self aftetGetContentArray:getArray];
            [self.tableView.footer endRefreshing];
        }andErrorBlock:^(NSError *error) {
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
    return self.contentArr.count;
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
        [_delegate pushToViewController:travelDetailViewController];
        [travelDetailViewController release];
    }
}

//创建HUB
- (void)createHub{
    self.hub = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [self.hub setDelegate:self];
    self.placeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
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
@end
