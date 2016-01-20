//
//  CollectionViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/22.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "CollectionViewController.h"
#import "Home_TravelCell.h"
#import "Topic_Cell.h"
#import "AreaPlansCell.h"
#import "CollectionSiteCell.h"
#import "Home_TravelContent.h"
#import "Topic_Content.h"
#import "AreaPlanModel.h"
#import "AreaSiteModel.h"
#import "User_Model.h"
#import "AreaEnterNavigationBar.h"
#import "DataBaseHandle.h"
#import "AreaSiteEnterSectionView.h"
#import "TravelDetailViewController.h"
#import "Topic_DetailViewController.h"
#import "AreaPlanEnterViewController.h"
#import "AreaSiteEnterViewController.h"
@interface CollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)AreaEnterNavigationBar *customBar;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *travelArray;
@property (nonatomic,retain)NSMutableArray *topicArray;
@property (nonatomic,retain)NSMutableArray *siteArray;
@property (nonatomic,retain)NSMutableArray *planArray;
@end

@implementation CollectionViewController
- (void)dealloc
{
    [_customBar release];
    [_travelArray release];
    [_topicArray release];
    [_siteArray release];
    [_planArray release];
    [_tableView release];
    [super dealloc];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [self getData];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self createTableView];
    //创建自定义navBar
    [self createCustomBar];
}
- (void)getData{
    self.travelArray = [[DataBaseHandle shareDataBaseHandle]selectAllTravel];
    self.topicArray = [[DataBaseHandle shareDataBaseHandle]selectAllTopic];
    self.siteArray = [[DataBaseHandle shareDataBaseHandle]selectAllSite];
    self.planArray = [[DataBaseHandle shareDataBaseHandle]selectAllPlan];
}
- (void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, kWidth, kHeight - 44) style:UITableViewStylePlain];
    [self.tableView setBackgroundColor:[UIColor blackColor]];
    [self.tableView setDelegate:self];
    [self.tableView registerClass:[CollectionSiteCell class] forCellReuseIdentifier:@"collectionSiteCell"];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:self.tableView];
    [_tableView release];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rowNumber = 0;
    switch (section) {
        case 0:
            rowNumber = self.travelArray.count;
            break;
        case 1:
            rowNumber = self.topicArray.count;
            break;
        case 2:
            rowNumber = self.planArray.count;
            break;
        case 3:
            rowNumber = self.siteArray.count;
            break;
    }
    return rowNumber;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        Home_TravelCell *cell = [Home_TravelCell Home_TravelCellWithTableView:tableView];
        Home_TravelContent *temp = self.travelArray[indexPath.row];
        cell.content = temp;
        return cell;
    }else if (indexPath.section == 1){
        Topic_Cell *cell = [Topic_Cell topic_CellWithTableView:tableView];
        Topic_Content *temp = self.topicArray[indexPath.row];
        cell.content = temp;
        return cell;
    }else if (indexPath.section == 2){
        AreaPlansCell *cell = [AreaPlansCell areaPlansCellWithTableView:tableView];
        AreaPlanModel *temp = self.planArray[indexPath.row];
        cell.content = temp;
        return cell;
    }else{
        CollectionSiteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"collectionSiteCell" forIndexPath:indexPath];
        AreaSiteModel *temp = self.siteArray[indexPath.row];
        cell.Content = temp;
        return cell;
    }
}
//每个cell的行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return kHeight / 8;
    }
    return kHeight / 2.6;
}
//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TravelDetailViewController *travelDetailViewController = [[TravelDetailViewController alloc]init];
        if (self.travelArray.count) {
            Home_TravelContent *temp = self.travelArray[indexPath.row];
            travelDetailViewController.titileContent = temp;
            [self.navigationController pushViewController:travelDetailViewController animated:YES];
            [travelDetailViewController release];
        }
    }else if (indexPath.section == 1){
        if (self.topicArray.count) {
            Topic_DetailViewController *topic_DetailViewController = [[Topic_DetailViewController alloc]init];
            topic_DetailViewController.topic_Content = self.topicArray[indexPath.row];
            [self.navigationController pushViewController:topic_DetailViewController animated:YES];
            [topic_DetailViewController release];
        }
    }else if (indexPath.section == 2){
        if (self.planArray.count) {
            AreaPlanEnterViewController *planEnterViewController = [[AreaPlanEnterViewController alloc]init];
            planEnterViewController.planEnter_Content = self.planArray[indexPath.row];
            [self.navigationController pushViewController:planEnterViewController animated:YES];
            [planEnterViewController release];
        }
    }else{
        if (self.siteArray.count) {
            AreaSiteModel *temp = self.siteArray[indexPath.row];
            AreaSiteEnterViewController *areaSiteEnterViewController = [[AreaSiteEnterViewController alloc]init];
            areaSiteEnterViewController.content = temp;
            [self.navigationController pushViewController:areaSiteEnterViewController animated:YES];
            [areaSiteEnterViewController release];
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AreaSiteEnterSectionView *headerView = [[AreaSiteEnterSectionView alloc]initWithFrame:CGRectMake(0, 0, kWidth, 35)];
    [headerView.contentLabel setBackgroundColor:[UIColor blackColor]];
    [headerView.contentLabel setTextColor:[UIColor whiteColor]];
    [headerView.contentLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    UIView *happyView = [[UIView alloc]initWithFrame:CGRectMake(0, 35 - 1, kWidth, 1)];
    [happyView setBackgroundColor:[UIColor grayColor]];
    [headerView addSubview:happyView];
    [happyView release];
    switch (section) {
        case 0:
            headerView.title = @"游记收藏";
            break;
        case 1:
            headerView.title = @"专题收藏";
            break;
        case 2:
            headerView.title = @"行程收藏";
            break;
        case 3:
            headerView.title = @"旅行地收藏";
            break;
    }
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
//创建自定义bar
- (void)createCustomBar{
    self.customBar = [[AreaEnterNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.customBar.titleView setText:@"我的收藏"];
    [self.customBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customBar];
    [_customBar release];
}
- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [self.tableView setEditing:YES animated:YES];
}
//2
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//3
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
//4
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            Home_TravelContent *temp = self.travelArray[indexPath.row];
            [[DataBaseHandle shareDataBaseHandle]deleteTravel:temp.ID];
            [self.travelArray removeObject:temp];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if (indexPath.section == 1){
            Topic_Content *temp = self.topicArray[indexPath.row];
            [[DataBaseHandle shareDataBaseHandle]deleteTopic:temp.ID];
            [self.topicArray removeObject:temp];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if (indexPath.section == 2){
            AreaPlanModel *temp = self.planArray[indexPath.row];
            [[DataBaseHandle shareDataBaseHandle]deletePlan:temp.ID];
            [self.planArray removeObject:temp];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else{
            AreaSiteModel *temp = self.siteArray[indexPath.row];
            [[DataBaseHandle shareDataBaseHandle]deleteSite:temp.ID];
            [self.siteArray removeObject:temp];
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
