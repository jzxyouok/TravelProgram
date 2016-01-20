//
//  AreaSiteEnterViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaSiteEnterViewController.h"
#import "AreaSiteModel.h"
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "CustomNavigationBar_Detail.h"
#import "CustomerNetworking.h"
#import "AutoSize.h"
#import "MBProgressHUD.h"
#import "EndView.h"
#import "ErrorNetWorkLabel.h"
#import "SingleStaues.h"
#import "AreaSiteEnterTitleView.h"
#import "AreaSiteEnterModel.h"
#import "TripTagsModel.h"
#import "RowModel.h"
#import "AreaSiteEnterUpView.h"
#import "AreaSiteEnterSectionView.h"
#import "AreaSiteEnterCell.h"
#import "AreaTravelEnterViewController.h"
#import "PhotoPageViewController.h"
#import "AreaEnterModel.h"
#import "GoMapViewController.h"
#import "DataBaseHandle.h"
#import "LeftView.h"//左侧视图view
#import "UMSocial.h"
@interface AreaSiteEnterViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,LeftViewDelegate,UMSocialUIDelegate,AreaSiteEnterCellDelegate>
@property (nonatomic,retain)CustomNavigationBar_Detail *customBar;
@property (nonatomic,retain)UIImageView *shadowPic;
@property (nonatomic,retain)AreaSiteEnterTitleView *titleView;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *contentArr;
@property (nonatomic,retain)MBProgressHUD *hub;
@property (nonatomic,retain)AreaSiteEnterUpView *upView;
@property (nonatomic,retain)AreaSiteEnterModel *titleContentModel;
@property (nonatomic,retain)UIImageView *placeImageView;
@property (nonatomic,assign)CGFloat upViewHeight;
@property (nonatomic,retain)AreaSiteEnterModel *enterModel;
@property (nonatomic,retain)NSMutableArray *nsindexPathArray;//左侧视图传入数组一
@property (nonatomic,retain)NSMutableArray *zeroNames;//左侧视图传入数组二(reloadData在这个数组赋值给view时触发)
@property (nonatomic,retain)LeftView *leftView;//左侧视图
@property (nonatomic,retain)UIButton *leftViewButton;//引出左侧视图的按钮
@end

@implementation AreaSiteEnterViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}
- (void)dealloc
{
    [_leftViewButton release];
    [_leftView release];
    [_nsindexPathArray release];
    [_zeroNames release];
    [_enterModel release];
    [_upView release];
    [_titleContentModel release];
    [_titleView release];
    [_shadowPic release];
    [_tableView release];
    [_hub release];
    [_placeImageView release];
    [_customBar release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    //创建自定义头视图
    [self createCustomTitleView];
    //创建TableView
    [self createTableView];
    //创建Hub
    [self createHub];
    //创建自定义navBar
    [self createCustomBar];
    //创建leftView
    [self createLeftView];//在获得数据前创建左侧视图
    
    [self addSwipeGesture];
    //请求数据
    [self getDateSource];
}
//创建自定义titleView
- (void)createCustomTitleView{
    self.titleView = [[AreaSiteEnterTitleView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 250)];
    [self.titleView setTitileContent:self.content];
    [self.view addSubview:self.titleView];
    [_titleView release];
}
//创建tableView
- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64 ) style:UITableViewStyleGrouped];
    [self.tableView setBounces:NO];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    self.upView = [[AreaSiteEnterUpView alloc]init];
    [self.upView.goMap addTarget:self action:@selector(goMap:) forControlEvents:UIControlEventTouchUpInside];
    [self.upView.goPhoto addTarget:self action:@selector(goPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.upView.goTravel addTarget:self action:@selector(goTravel:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:self.upView];
    [_tableView release];
}
- (void)goMap:(UIButton *)btn{
    GoMapViewController *goMap = [[GoMapViewController alloc]init];
    [goMap setName:_content.name];
    [goMap setLat:[_enterModel.lat doubleValue]];
    [goMap setLng:[_enterModel.lng doubleValue]];
    [self.navigationController pushViewController:goMap animated:YES];
    [goMap release];
}
- (void)goPhoto:(UIButton *)btn{
    PhotoPageViewController *photo = [[PhotoPageViewController alloc]init];
    photo.content = self.enterModel;
    [self.navigationController pushViewController:photo animated:YES];
    [photo release];
}
- (void)goTravel:(UIButton *)btn{
    AreaTravelEnterViewController *travel = [[AreaTravelEnterViewController alloc]init];
    travel.content = self.enterModel.useEnterModel;
    [self.navigationController pushViewController:travel animated:YES];
    [travel release];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.contentArr.count ? self.contentArr.count : 0 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TripTagsModel *temp = self.contentArr[section];
    return [temp.rowsArray count];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TripTagsModel *temp = self.contentArr[section];
    AreaSiteEnterSectionView *headerView = [[AreaSiteEnterSectionView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    headerView.title = temp.name;
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == self.contentArr.count-1) {
        EndView *endView = [[EndView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 30)];
        return endView;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section != self.contentArr.count-1) {
        return 1;
    } else {
        return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TripTagsModel *tag = self.contentArr[indexPath.section];
    RowModel *rowModel = tag.rowsArray[indexPath.row];
    CGFloat labelHeight = [AutoSize AutoSizeOfHeightWithText:rowModel.descriptionFHY andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth - 20];
    CGFloat picYesOrNo = rowModel.picArray.count ? 0 : 150;
    return 183 + labelHeight - picYesOrNo;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AreaSiteEnterCell *areaSiteEnterCell = [AreaSiteEnterCell areaSiteEnterCellWithTableView:tableView];
    [areaSiteEnterCell setDelegate:self];
    if (self.contentArr.count) {
        TripTagsModel *tag = self.contentArr[indexPath.section];
        RowModel *rowModel = tag.rowsArray[indexPath.row];
        [areaSiteEnterCell setRowContent:rowModel];
    }
    return areaSiteEnterCell;
}
- (void)pushToPhotoViewController:(UIViewController *)photoEnterViewController{
    [self.navigationController pushViewController:photoEnterViewController animated:YES];
}
//滑动隐藏CustomBar
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = - (scrollView.contentOffset.y + 250 + self.upViewHeight) + 64 - 35.21;
    if (y > - 186) {
        [self.customBar.titleView setAlpha:1 * (- y / 186)];
        [self.titleView setFrame:CGRectMake(0, y, kWidth, 250)];
        [self.titleView.blackView setAlpha:1 * (- y / 186)];
    }else if (y < - 186){
        //当滑动到这个状态时显现左侧视图button
        [self.leftViewButton setHidden:NO];
        [self.titleView.blackView setAlpha:1];
        [self.customBar.titleView setAlpha:1];
    }
}
//创建HUB
- (void)createHub{
    self.hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.hub setDelegate:self];
    self.placeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 250 - 64, kWidth, kHeight)];
    [self.placeImageView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:self.placeImageView];
    [_placeImageView release];
}
//创建自定义bar
- (void)createCustomBar{
    self.customBar = [[CustomNavigationBar_Detail alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.customBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.customBar.shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];//shareBtn
    NSArray *getData = [[DataBaseHandle shareDataBaseHandle]selectAllSite];
    if (getData.count) {
        for (AreaSiteModel *collectionInfo in getData) {
            if ([[collectionInfo.ID description] isEqualToString:[_content.ID description]]) {
                [self.customBar.collectionButton setImage:[UIImage imageNamed:@"nav_like_2"] forState:UIControlStateNormal];
                break;
            }
            else{
                [self.customBar.collectionButton setImage:[UIImage imageNamed:@"nav_like"] forState:UIControlStateNormal];
            }
        }
    }else{
        [self.customBar.collectionButton setImage:[UIImage imageNamed:@"nav_like"] forState:UIControlStateNormal];
    }
    [self.customBar.collectionButton addTarget:self action:@selector(siteCollection:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customBar];
    [_customBar release];
    
    //给一层遮挡
    self.shadowPic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"DestinationItemShadow"]];
    [self.shadowPic setFrame:self.customBar.frame];
    [self.view addSubview:self.shadowPic];
    [_shadowPic release];
}
- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)share{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"562737e6e0f55ada18000028"
                                      shareText:[NSString stringWithFormat:@"我正在使用 <行者日记> App浏览旅行地－%@的介绍。    行者日记，把世界推到你面前。",_content.name]
                                     shareImage:_titleView.backGroundPic.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,nil]
                                       delegate:nil];
}
- (void)siteCollection:(UIButton *)btn{
    if ([btn.imageView.image isEqual:[UIImage imageNamed:@"nav_like"]]) {
        [btn setImage:[UIImage imageNamed:@"nav_like_2"] forState:UIControlStateNormal];
        [[DataBaseHandle shareDataBaseHandle]insertSiteDetail:_content];
    } else {
        [btn setImage:[UIImage imageNamed:@"nav_like"] forState:UIControlStateNormal];
        [[DataBaseHandle shareDataBaseHandle]deleteSite:_content.ID];
    }
}
//请求数据
- (void)getDateSource{
    //首先从本地获取数据
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *areaSiteEnterLast = [diaryInfo stringByAppendingPathComponent:[NSString stringWithFormat:@"areaSiteEnterLast%@.plist",self.content.ID]];
    NSDictionary *getMyData = [NSKeyedUnarchiver unarchiveObjectWithFile:areaSiteEnterLast];
    if (getMyData) {
        [self aftetGetContentDictionary:getMyData];
    } else {
        if ([[SingleStaues shareNetStatus]statues]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/attractions/%@.json?page=1",self.content.ID] andParameters:nil andBlock:^(id responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSDictionary *getDictionary = responseObject;
                [NSKeyedArchiver archiveRootObject:responseObject toFile:areaSiteEnterLast];
                [self aftetGetContentDictionary:getDictionary];
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
    [self.hub removeFromSuperview];
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
- (void)aftetGetContentDictionary:(NSDictionary *)dictionary{
    self.enterModel = [[AreaSiteEnterModel alloc]initWithDictionary:dictionary];
    NSInteger section = 0;
    for (NSDictionary *sectionDic in [dictionary objectForKey:@"attraction_trip_tags"]) {
        TripTagsModel *tripTag = [[TripTagsModel alloc]initWithDictionary:sectionDic];
        
        [self.zeroNames addObject:tripTag.name];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        section++;
        [self.nsindexPathArray addObject:indexPath];
        
        [self.contentArr addObject:tripTag];
        [tripTag release];
    }
    [self.leftView setNsIndexPathArray:_nsindexPathArray];
    [self.leftView setTitileArray:_zeroNames];
    CGFloat upViewHeight = [AutoSize AutoSizeOfHeightWithText:self.enterModel.descriptionFHY andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth - 20];
    //创建upView
    self.upViewHeight = 65 + upViewHeight;
    [self.upView setFrame:CGRectMake(0, - (65 + 35.21 + upViewHeight), kWidth, 65 + upViewHeight + 38)];
    [self.tableView setContentInset:UIEdgeInsetsMake(250 - 64 + 100 + upViewHeight, 0, 0, 0)];
    [self.customBar.titleView setText:[dictionary objectForKey:@"name_zh_cn"]];
    [self.upView setUpViewContent:self.enterModel];
    [self.tableView reloadData];
    [self.hub removeFromSuperview];
    [self.placeImageView removeFromSuperview];
}

//创建左侧视图
- (void)createLeftView{
    self.leftViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftViewButton setImage:[UIImage imageNamed:@"leftViewBtn"] forState:UIControlStateNormal];
    [self.leftViewButton setHidden:YES];
    [self.leftViewButton addTarget:self action:@selector(leftViewShow) forControlEvents:UIControlEventTouchUpInside];
    [self.leftViewButton setFrame:CGRectMake(10, kHeight - 54, 44, 44)];
    [self.view addSubview:self.leftViewButton];
    
    self.leftView = [[LeftView alloc]initWithFrame:CGRectMake(- kWidth * 2, 63, kWidth, kHeight - 62)];
    
    [self.leftView.bigButton addTarget:self action:@selector(leftViewHidden) forControlEvents:UIControlEventTouchUpInside];
    [self.leftView setDelegate:self];
    [self.view addSubview:self.leftView];
    [_leftView release];
}
//代理方法
- (void)scrollTo:(NSIndexPath *)indexPath{
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (void)leftViewHidden{
    [UIView animateWithDuration:0.5 animations:^{
        [self.leftView setFrame:CGRectMake(- kWidth * 2, 63, kWidth, kHeight - 62)];
    }];
}
- (void)leftViewShow{
    [UIView animateWithDuration:0.5 animations:^{
        [self.leftView setFrame:CGRectMake(0, 63, kWidth, kHeight - 62)];
    }];
}

//添加手势
- (void)addSwipeGesture{
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.leftView addGestureRecognizer:swipeLeft];
    [swipeLeft release];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.tableView addGestureRecognizer:swipeRight];
    [swipeRight release];
}
- (void)leftSwipe{
    if (self.leftView.frame.origin.x == 0) {
        [self leftViewHidden];
    }
}
- (void)rightSwipe{
    if (self.leftView.frame.origin.x != 0) {
        [self leftViewShow];
    }
}

//懒加载
- (NSMutableArray *)contentArr{
    if (_contentArr == nil) {
        _contentArr = [[NSMutableArray alloc]init];
    }
    return _contentArr;
}
- (NSMutableArray *)nsindexPathArray{
    if (_nsindexPathArray == nil) {
        _nsindexPathArray = [[NSMutableArray alloc]init];
    }
    return _nsindexPathArray;
}
- (NSMutableArray *)zeroNames{
    if (_zeroNames == nil) {
        _zeroNames = [[NSMutableArray alloc]init];
    }
    return _zeroNames;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
