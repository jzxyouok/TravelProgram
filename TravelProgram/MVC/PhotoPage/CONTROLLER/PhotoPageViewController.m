//
//  PhotoPageViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "EqualWidthLayOut.h"
#import "CustomerNetworking.h"
#import "AutoSize.h"
#import "AreaSiteEnterModel.h"
#import "MBProgressHUD.h"
#import "ErrorNetWorkLabel.h"
#import "SingleStaues.h"
#import "AFNetworking.h"
#import <MJRefresh.h>
#import "AreaSiteCustomNavBar.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoPageModel.h"
#import "PhotoPageViewController.h"
#import "PhotoEnterViewController.h"
@interface PhotoPageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,EqualWidthLayOutDelegate,MBProgressHUDDelegate>
@property (nonatomic,assign)NSInteger pageNumber;
@property (nonatomic,retain)AreaSiteCustomNavBar *customBar;
@property (nonatomic,retain)UICollectionView *collectionView;
@property (nonatomic,retain)NSMutableArray *contentArr;
@property (nonatomic,retain)MBProgressHUD *hub;
@property (nonatomic,retain)UIImageView *placeImageView;
@end

@implementation PhotoPageViewController
- (void)dealloc
{
    [_content release];
    [_placeImageView release];
    [_hub release];
    [_customBar release];
    [_contentArr release];
    [_collectionView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建CollectionView
    [self createCollectionView];
    //创建Hub
    [self createHub];
    //创建自定义NavBar
    [self createCustomBar];
    //数据解析
    [self getDataSourse];
}
//创建CollectionView
- (void)createCollectionView{
    EqualWidthLayOut *layout = [[EqualWidthLayOut alloc]init];
    [layout setDelegate:self];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 44, kWidth, kHeight - 44) collectionViewLayout:layout];
    [self createRefresh];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photoCollectionViewCell"];
    [self.collectionView setBackgroundColor:[UIColor colorWithRed:0.051 green:0.0745 blue:0.2 alpha:1.0]];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:self.collectionView];
    [_collectionView release];
}
//创建上拉刷新下拉加载
- (void)createRefresh{
    [self.collectionView setFooter:[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageNumber++;
        [self downRefresh];
    }]];
}
//下拉后实行网络请求
- (void)downRefresh{
    if ([[SingleStaues shareNetStatus]statues]) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/attractions/%@/photos.json?per_page=20&page=%ld",self.content.ID,(long)self.pageNumber] andParameters:nil andBlock:^(id responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSArray *getArray = responseObject;
            [self aftetGetContentArray:getArray];
        }andErrorBlock:^(NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self.collectionView.footer endRefreshing];
            [self badNetWork];
        }];
    } else {
        [self.collectionView.footer endRefreshing];
        [self badNetWork];
    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.contentArr.count ? self.contentArr.count : 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoPageModel *temp = self.contentArr[indexPath.row];
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCollectionViewCell" forIndexPath:indexPath];
    cell.cellContent = temp;
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)view layout:(EqualWidthLayOut *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoPageModel *temp = self.contentArr[indexPath.row];
    CGFloat  kCellWidth = (kWidth - 10 * 3) / 2;
    return  kCellWidth * ( [temp.image_height floatValue] / [temp.image_width floatValue] );
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoEnterViewController *enter = [[PhotoEnterViewController alloc]init];
    enter.contentArray = self.contentArr;
    enter.photoNumber = indexPath.row;
    [self.navigationController pushViewController:enter animated:YES];
    [enter release];
}
//创建HUB
- (void)createHub{
    self.placeImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.placeImageView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.placeImageView];
    [_placeImageView release];
    self.hub = [MBProgressHUD showHUDAddedTo:self.placeImageView animated:YES];
    [self.hub setDelegate:self];
}
//创建自定义bar
- (void)createCustomBar{
    self.customBar = [[AreaSiteCustomNavBar alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.customBar.titleView setText:[NSString stringWithFormat:@"%@|相册",_content.name_zh_cn]];
    [self.customBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customBar];
    [_customBar release];
}
- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}
//数据解析
- (void)getDataSourse{
    if ([[SingleStaues shareNetStatus]statues]) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/attractions/%@/photos.json?per_page=20&page=1",self.content.ID] andParameters:nil andBlock:^(id responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSArray *getArray = responseObject;
            [self aftetGetContentArray:getArray];
        }andErrorBlock:^(NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self.collectionView.footer endRefreshing];
            [self badNetWork];
        }];
    } else {
        [self.collectionView.footer endRefreshing];
        [self badNetWork];
    }
}
//拿到数据后
- (void)aftetGetContentArray:(NSArray *)array{
    for (NSDictionary *dictionary in array) {
        PhotoPageModel *oneContent = [[PhotoPageModel alloc]initWithDictionary:dictionary];
        [self.contentArr addObject:oneContent];
        [oneContent release];
    }
    [self.collectionView reloadData];
    [self.collectionView.footer endRefreshing];
    [self.hub removeFromSuperview];
    [self.placeImageView removeFromSuperview];
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


- (NSMutableArray *)contentArr{
    if (_contentArr == nil) {
        _contentArr = [[NSMutableArray alloc]init];
    }
    return _contentArr;
}
- (NSInteger)pageNumber{
    if (_pageNumber == 0) {
        _pageNumber = 1;
    }
    return _pageNumber;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
