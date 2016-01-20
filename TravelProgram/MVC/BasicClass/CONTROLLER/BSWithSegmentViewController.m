//
//  BSWithSegmentViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithSegmentViewController.h"
#import "CustomNavigationBar_Area.h"
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
@interface BSWithSegmentViewController ()
@end

@implementation BSWithSegmentViewController
- (void)dealloc
{
    [_customNavigationBar release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建NaviegationBar
    [self createNaviegationBar];
}
//创建NaviegationBar
- (void)createNaviegationBar{
    self.customNavigationBar = [[CustomNavigationBar_Area alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    //添加点击事件
    [self.customNavigationBar.searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.china addTarget:self action:@selector(china:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.otherCountry addTarget:self action:@selector(state:) forControlEvents:UIControlEventTouchUpInside];
    [self.customNavigationBar.myPageButton addTarget:self action:@selector(myPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customNavigationBar];
    [_customNavigationBar release];
}
- (void)china:(UIButton *)chinaBtn{
    [chinaBtn setImage:[UIImage imageNamed:@"nav_area"] forState:UIControlStateNormal];
    [chinaBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.customNavigationBar.otherCountry setImage:[UIImage imageNamed:@"nav_areaNormo2"] forState:UIControlStateNormal];
    [self.customNavigationBar.otherCountry setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}
- (void)state:(UIButton *)otherCountry{
    [self.customNavigationBar.china setImage:[UIImage imageNamed:@"nav_areaNormol"] forState:UIControlStateNormal];
    [self.customNavigationBar.china setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [otherCountry setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [otherCountry setImage:[UIImage imageNamed:@"nav_area2"] forState:UIControlStateNormal];
    
}
- (void)searchAction:(UIButton *)btn{
}
- (void)myPage:(UIButton *)myPageBtn{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
