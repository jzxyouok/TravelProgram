//
//  Topic_DetailViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/12.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "Topic_DetailViewController.h"
#import "CustomNavigationBar_Detail.h"
#import "CustomerNetworking.h"
#import "AutoSize.h"
#import "MBProgressHUD.h"
#import "EndView.h"
#import "Topic_Content.h"
#import "Topic_Detail_TitleView.h"
#import "Topic_Detail_Model.h"
#import "Topic_Detail_CellOne.h"
#import "Topic_Detail_CellTwo.h"
#import "Topic_Detail_CellThree.h"
#import "Topic_Detail_CellFour.h"
#import "ErrorNetWorkLabel.h"
#import "SingleStaues.h"
#import "DataBaseHandle.h"
#import "LeftView.h"//左侧视图view
#import "UMSocial.h"//UMeng
@interface Topic_DetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,MBProgressHUDDelegate,LeftViewDelegate,UMSocialUIDelegate>
@property (nonatomic,retain)CustomNavigationBar_Detail *customBar;
@property (nonatomic,retain)UIImageView *shadowPic;
@property (nonatomic,retain)Topic_Detail_TitleView *titleView;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *contentArr;
@property (nonatomic,retain)MBProgressHUD *hub;
@property (nonatomic,retain)UIImageView *placeImageView;
@property (nonatomic,retain)NSMutableArray *nsindexPathArray;//左侧视图传入数组一
@property (nonatomic,retain)NSMutableArray *zeroNames;//左侧视图传入数组二(reloadData在这个数组赋值给view时触发)
@property (nonatomic,retain)LeftView *leftView;//左侧视图
@property (nonatomic,assign)NSInteger leftViewCount;//判定左侧视图的数组是否已经填满
@property (nonatomic,retain)UIButton *leftViewButton;//引出左侧视图的按钮
@end

@implementation Topic_DetailViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}
- (void)dealloc
{
    [_topic_Content release];
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
//创建自定义bar
- (void)createCustomBar{
    self.customBar = [[CustomNavigationBar_Detail alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.customBar.titleView setText:self.topic_Content.name];
    [self.customBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.customBar.shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];//shareBtn
    NSArray *getData = [[DataBaseHandle shareDataBaseHandle]selectAllTopic];
    if (getData.count) {
        for (Topic_Content *collectionInfo in getData) {
            if ([[collectionInfo.ID description] isEqual:[_topic_Content.ID description]]) {
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
    [self.customBar.collectionButton addTarget:self action:@selector(topicCollection:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)topicCollection:(UIButton *)btn{
    if ([btn.imageView.image isEqual:[UIImage imageNamed:@"nav_like"]]) {
        [btn setImage:[UIImage imageNamed:@"nav_like_2"] forState:UIControlStateNormal];
        [[DataBaseHandle shareDataBaseHandle]insertTopicDetail:_topic_Content];
    } else {
        [btn setImage:[UIImage imageNamed:@"nav_like"] forState:UIControlStateNormal];
        [[DataBaseHandle shareDataBaseHandle]deleteTopic:_topic_Content.ID];
    }
}
//创建自定义titleView
- (void)createCustomTitleView{
    self.titleView = [[Topic_Detail_TitleView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 250)];
    [self.titleView setTitilContent:self.topic_Content];
    [self.view addSubview:self.titleView];
    [_titleView release];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    return self.contentArr.count ? 1 : 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArr.count ? self.contentArr.count : 0;
}
//最后的end视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        EndView *endView = [[EndView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 50)];
        return endView;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 1)];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.contentArr.count) {
        Topic_Detail_Model *temp = self.contentArr[indexPath.row];
        CGFloat textHeight = [AutoSize AutoSizeOfHeightWithText:temp.DescriptionMutable andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth - 20];
        if (temp.title.length != 0) {
            if (_leftViewCount > self.zeroNames.count) {
                [self.zeroNames addObject:temp.title];
                [self.nsindexPathArray addObject:indexPath];
            }
            if (temp.image_url.length != 0) {
                //文字和图片
    CGFloat imageHeight = (kWidth - 20) * ([temp.image_height floatValue] / [temp.image_width floatValue]);
                return 50 + textHeight + imageHeight;
            }else{
                return 50 + textHeight;
            }
        }else{
            if (temp.image_url.length != 0) {
        CGFloat imageHeight = (kWidth - 20) * ([temp.image_height floatValue] / [temp.image_width floatValue]);
                //文字和图片
                return 30 + imageHeight + textHeight;
            }else{
                //仅有文字描述
                return 30 + textHeight;
            }
        }
    }
        return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.contentArr.count) {
        Topic_Detail_Model *temp = self.contentArr[indexPath.row];
    if (temp.title.length != 0) {
        if (temp.image_url.length != 0) {
            //文字和图片
            Topic_Detail_CellFour *cell = [Topic_Detail_CellFour topic_Detail_CellFourWithTableView:tableView];
            cell.cellContent = temp;
            return cell;
        }else{
            Topic_Detail_CellTwo *cell = [Topic_Detail_CellTwo topic_Detail_CellTwoWithTableView:tableView];
            cell.cellContent = temp;
            return cell;
        }
    }else{
        if (temp.image_url.length != 0) {
            //文字和图片
            Topic_Detail_CellThree *cell = [Topic_Detail_CellThree topic_Detail_CellThreeWithTableView:tableView];
            cell.cellContent = temp;
            return cell;
        }else{
            //仅有文字描述
            Topic_Detail_CellOne *cell = [Topic_Detail_CellOne topic_Detail_CellOneWithTableView:tableView];
            cell.cellContent = temp;
            return cell;
        }
    }
}
    
    return [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"test"];
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
//请求数据
- (void)getDateSource{
    //首先从本地获取数据
    NSString *diaryInfo = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"diaryInfo"];
    NSString *detailTopicPageContent = [diaryInfo stringByAppendingPathComponent:[NSString stringWithFormat:@"detailTopicPageContent%@.plist",self.topic_Content.ID]];
    NSDictionary *getMyData = [NSKeyedUnarchiver unarchiveObjectWithFile:detailTopicPageContent];
    if (getMyData) {
        [self aftetGetContentDictionary:getMyData];
    } else {
        if ([[SingleStaues shareNetStatus]statues]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            [CustomerNetworking connectWithURLString:[NSString stringWithFormat:@"https://chanyouji.com/api/articles/%@.json?page=1",self.topic_Content.ID] andParameters:nil andBlock:^(id responseObject) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                NSDictionary *getDictionary = responseObject;
                [NSKeyedArchiver archiveRootObject:responseObject toFile:detailTopicPageContent];
                [self aftetGetContentDictionary:getDictionary];
            } andErrorBlock:^(NSError *error) {
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
    NSArray *array = [dictionary objectForKey:@"article_sections"];
    for (NSDictionary *tips in array) {
        Topic_Detail_Model *detailContent = [[Topic_Detail_Model alloc]initWithDictionary:tips];
        if (detailContent.title.length != 0) {
            self.leftViewCount++;
        }
        for (NSString *userId in [detailContent.description_user_ids allKeys]) {
            NSString *replaceString = [NSString stringWithFormat:@"%@☞",[detailContent.description_user_ids objectForKey:userId]];
            detailContent.DescriptionMutable = [detailContent.DescriptionMutable stringByReplacingOccurrencesOfString:userId withString:replaceString];
        }
        if (detailContent.DescriptionMutable.length > 8 ? ![[detailContent.DescriptionMutable substringToIndex:8] isEqualToString:@"#蝉游记公众号#"] : 1) {
            [self.contentArr addObject:detailContent];
            [detailContent release];
        }
    }
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
- (void)share{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"562737e6e0f55ada18000028"
                                      shareText:[NSString stringWithFormat:@"我正在使用 <行者日记> App阅读旅行专题《%@》。    行者日记，把世界推到你面前。",_topic_Content.name]
                                     shareImage:_titleView.backGroundPic.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToSms,nil]
                                       delegate:nil];
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
@end
