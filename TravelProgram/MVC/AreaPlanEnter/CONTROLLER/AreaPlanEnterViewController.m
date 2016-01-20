//
//  AreaPlanEnterViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "AreaPlanEnterViewController.h"
#import "CustomNavigationBar_Detail.h"
#import "CustomerNetworking.h"
#import "AutoSize.h"
#import "MBProgressHUD.h"
#import "EndView.h"
#import "ErrorNetWorkLabel.h"
#import "SingleStaues.h"
#import "PlanEnterOne.h"
#import "PlanEnterTwo.h"
#import "AreaPlanModel.h"
#import "AreaPlanEnterTitleView.h"
#import "PlanEnterTableViewSectionHeaderView.h"
#import "AreaPlanEnterMemoCell.h"
#import "AreaPlanEnterCell.h"
#import "DataBaseHandle.h"
#import "LeftView.h"//左侧视图view
#import "UMSocial.h"
@interface AreaPlanEnterViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,LeftViewDelegate,UMSocialUIDelegate>
@property (nonatomic,retain)CustomNavigationBar_Detail *customBar;
@property (nonatomic,retain)UIImageView *shadowPic;
@property (nonatomic,retain)AreaPlanEnterTitleView *titleView;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *contentArr;
@property (nonatomic,retain)MBProgressHUD *hub;
@property (nonatomic,retain)UIImageView *placeImageView;
@property (nonatomic,retain)NSMutableArray *nsindexPathArray;//左侧视图传入数组一
@property (nonatomic,retain)NSMutableArray *zeroNames;//左侧视图传入数组二(reloadData在这个数组赋值给view时触发)
@property (nonatomic,retain)LeftView *leftView;//左侧视图
@property (nonatomic,assign)NSInteger leftViewArrayCount;
@property (nonatomic,retain)UIButton *leftViewButton;//引出左侧视图的按钮
@end

@implementation AreaPlanEnterViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}
- (void)dealloc
{
    [_planEnter_Content release];
    [_leftViewButton release];
    [_leftView release];
    [_nsindexPathArray release];
    [_zeroNames release];
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
    self.titleView = [[AreaPlanEnterTitleView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 250)];
    [self.titleView setTitileContent:self.planEnter_Content];
    [self.view addSubview:self.titleView];
    [_titleView release];
}
//创建tableView
- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64 ) style:UITableViewStyleGrouped];
    [self.tableView setContentInset:UIEdgeInsetsMake(250 - 64, 0, 0, 0)];
    [self.tableView setBounces:NO];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.view addSubview:self.tableView];
    [_tableView release];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.contentArr.count ? self.contentArr.count : 0 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PlanEnterOne *temp = self.contentArr[section];
    return self.contentArr.count ? [temp.oneArray count] : 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PlanEnterTableViewSectionHeaderView *headerView = [[PlanEnterTableViewSectionHeaderView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    headerView.sectionNumber = section;
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
    PlanEnterOne *oneModel = self.contentArr[indexPath.section];
    PlanEnterTwo *twoModel = oneModel.oneArray[indexPath.row];
    //再返回行高方法中给数组添加对象,填满后赋值给左侧视图
    if (indexPath.row == 0) {
       CGFloat textHeight = [AutoSize AutoSizeOfHeightWithText:oneModel.memo andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth - 20];
        return textHeight + 20 + 30;
    } else{
        if (_leftViewArrayCount > self.zeroNames.count) {
            [self.zeroNames addObject:twoModel.entry_name];
            [self.nsindexPathArray addObject:indexPath];
        }
        CGFloat textHeight = [AutoSize AutoSizeOfHeightWithText:twoModel.tips andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth - 20];
        CGFloat imageHeight = (kWidth - 20) * 0.57142;
        return textHeight + imageHeight + 60;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlanEnterOne *oneModel = self.contentArr[indexPath.section];
    PlanEnterTwo *twoModel = oneModel.oneArray[indexPath.row];
    if (indexPath.row == 0) {
        AreaPlanEnterMemoCell *cell = [AreaPlanEnterMemoCell areaPlanEnterMemoCellWithTableView:tableView];
        cell.memoCellContent = oneModel;
        return cell;
    } else{
        AreaPlanEnterCell *cell = [AreaPlanEnterCell areaPlanEnterCellWithTableView:tableView];
        cell.cellContent = twoModel;
        return cell;
    }
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
//滑动隐藏CustomBar
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = - (scrollView.contentOffset.y + 250) + 64;
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
    self.placeImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [self.placeImageView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView addSubview:self.placeImageView];
    [_placeImageView release];
}
//创建自定义bar
- (void)createCustomBar{
    self.customBar = [[CustomNavigationBar_Detail alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.customBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.customBar.shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];//shareBtn
    NSArray *getData = [[DataBaseHandle shareDataBaseHandle]selectAllPlan];
    if (getData.count) {
        for (AreaPlanModel *collectionInfo in getData) {
            if ([[collectionInfo.ID description] isEqualToString:[_planEnter_Content.ID description]]) {
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
    [self.customBar.collectionButton addTarget:self action:@selector(planCollection:) forControlEvents:UIControlEventTouchUpInside];
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
                                      shareText:[NSString stringWithFormat:@"我正在使用 <行者日记> App阅读旅行行程《%@》。    行者日记，把世界推到你面前。",_planEnter_Content.name]
                                     shareImage:_titleView.backGroundPic.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,nil]
                                       delegate:nil];
}
- (void)planCollection:(UIButton *)btn{
    if ([btn.imageView.image isEqual:[UIImage imageNamed:@"nav_like"]]) {
        [btn setImage:[UIImage imageNamed:@"nav_like_2"] forState:UIControlStateNormal];
        [[DataBaseHandle shareDataBaseHandle]insertPlanDetail:_planEnter_Content];
    } else {
        [btn setImage:[UIImage imageNamed:@"nav_like"] forState:UIControlStateNormal];
        [[DataBaseHandle shareDataBaseHandle]deletePlan:_planEnter_Content.ID];
    }
}
//请求数据
- (void)getDateSource{
    //首先从本地获取数据
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *areaPlanEnter = [diaryInfo stringByAppendingPathComponent:[NSString stringWithFormat:@"areaPlanEnter%@.plist",self.planEnter_Content.ID]];
    NSDictionary *getMyData = [NSKeyedUnarchiver unarchiveObjectWithFile:areaPlanEnter];
    if (getMyData) {
        [self aftetGetContentDictionary:getMyData];
    } else {
        if ([[SingleStaues shareNetStatus]statues]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/plans/%@.json?page=1",self.planEnter_Content.ID] andParameters:nil andBlock:^(id responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSDictionary *getDictionary = responseObject;
                [NSKeyedArchiver archiveRootObject:responseObject toFile:areaPlanEnter];
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
    NSArray *array = [dictionary objectForKey:@"plan_days"];
    for (NSDictionary *days in array) {
        PlanEnterOne *planContent = [[PlanEnterOne alloc]initWithDictionary:days];
        self.leftViewArrayCount += planContent.oneArray.count - 1;
        [self.contentArr addObject:planContent];
        [planContent release];
    }
    
    [self.customBar.titleView setText:[dictionary objectForKey:@"name"]];
    [self.tableView reloadData];
    //拿到数据后给左侧视图赋值
    if (_nsindexPathArray.count) {
        for (int i = 0; i < _nsindexPathArray.count - 1; i++) {
            for (int j = 0; j < _nsindexPathArray.count - 1 - i; j++) {
                if ([_nsindexPathArray[j] section] > [_nsindexPathArray[j + 1] section]){
                    NSIndexPath *temp = [self.nsindexPathArray[j] retain];
                    self.nsindexPathArray[j] = self.nsindexPathArray[j + 1];
                    self.nsindexPathArray[j + 1] = temp;
                    NSString *tempStr = _zeroNames[j];
                    _zeroNames[j] = _zeroNames[j + 1];
                    _zeroNames[j + 1] = tempStr;
                }
            }
        }
    }
    [self.leftView setNsIndexPathArray:_nsindexPathArray];
    [self.leftView setTitileArray:_zeroNames];
    [self.hub removeFromSuperview];
    [self.placeImageView removeFromSuperview];
    
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
