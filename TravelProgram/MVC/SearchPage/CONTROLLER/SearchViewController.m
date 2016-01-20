//
//  SearchViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "SearchViewController.h"
#import "CustomSearchBar.h"
#import "SearchButtonsView.h"
#import "Area_DestinationsModel.h"
#import "SearchResultView.h"
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
@interface SearchViewController ()<UITextFieldDelegate,SearchButtonsViewDelegate,searchResultViewDelegate>
@property (nonatomic,retain)CustomSearchBar *searchBar;
@property (nonatomic,retain)SearchButtonsView *searchButtonsView;
@property (nonatomic,retain)NSMutableArray *contentArray;
@property (nonatomic,retain)SearchResultView *searchResultView;
@end

@implementation SearchViewController

- (void)dealloc
{
    [_searchResultView release];
    [_contentArray release];
    [_searchBar release];
    [_searchButtonsView release];
    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self handleData];
    [self.view setBackgroundColor:[UIColor colorWithRed:0.8824 green:0.9059 blue:0.9333 alpha:1.0]];
    [self createSearchBar];
    [self createSearchResultView];
    [self createSearchButtonsView];
    
}
- (void)handleData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"searchFileUse" ofType:@"plist"];
    NSArray *getArray = [NSArray arrayWithContentsOfFile:path];
    self.contentArray = [NSMutableArray array];
    for (NSDictionary *dic in getArray) {
        for (NSDictionary *dicIn in [dic objectForKey:@"destinations"]) {
            Area_DestinationsModel *model = [[Area_DestinationsModel alloc]initWithDictionary:dicIn];
            [self.contentArray addObject:model];
            [model release];
        }
    }
}
 - (void)createSearchBar{
     self.searchBar = [[CustomSearchBar alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
     [self.searchBar.searchTextField setDelegate:self];
     [self.searchBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:self.searchBar];
     [_searchBar release];
 }
 - (void)popBack{
     [self.navigationController popViewControllerAnimated:YES];
 }

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.searchBar.searchTextField becomeFirstResponder];
}
//当点击搜索后!
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.searchBar.searchTextField resignFirstResponder];
    [self.searchResultView setSearchWord:textField.text];
    [self.searchResultView.tableView reloadData];
    [self.view bringSubviewToFront:self.searchResultView];
    return YES;
}
- (void)createSearchResultView{
    self.searchResultView = [[SearchResultView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight - 64)];
    [self.searchResultView setDelegate:self];
    [self.view addSubview:self.searchResultView];
    [_searchResultView release];
}
- (void)createSearchButtonsView{
    UILabel *upSearchLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, kWidth, 90 - 64)];
    [upSearchLabel setBackgroundColor:[UIColor blackColor]];
    [upSearchLabel setTextColor:[UIColor whiteColor]];
    [upSearchLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [upSearchLabel setText:@"快速搜索"];
    [upSearchLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:upSearchLabel];
    [upSearchLabel release];
    self.searchButtonsView = [[SearchButtonsView alloc]initWithFrame:CGRectMake(0, 90, kWidth, kHeight - 90)];
    [self.searchButtonsView setDelegate:self];
    [self.searchButtonsView setContentArray:_contentArray];
    [self.view addSubview:self.searchButtonsView];
    [_searchButtonsView release];
}
- (void)scrolling{
    [self.searchBar.searchTextField resignFirstResponder];
}
- (void)pushToViewController:(UIViewController *)viewController{
    [self.navigationController pushViewController:viewController animated:YES];
}
 - (void)didReceiveMemoryWarning {
     [super didReceiveMemoryWarning];
 }
 @end