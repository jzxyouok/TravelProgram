//
//  CustomSearchBar.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "CustomSearchBar.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height

@interface CustomSearchBar ()
@end
@implementation CustomSearchBar
- (void)dealloc
{
    [_searchTextField release];
    [_backButton release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        //创建自定义NavBar
        [self createBackButton];
        [self createSearchTextField];
    }
    return self;
}
//创建自定义NavBar
- (void)createBackButton{
    //创建返回键
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setFrame:CGRectMake(10, 25, 34, 34)];
    [self.backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [self.backButton setTintColor:[UIColor whiteColor]];
    [self.backButton setImage:[UIImage imageNamed:@"nav_back_two"] forState:UIControlStateHighlighted];
    [self addSubview:self.backButton];
}

- (void)createSearchTextField{
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(40, 30, kWidth - 64, 24)];
    [self.searchTextField setBackgroundColor:[UIColor whiteColor]];
    [self.searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.searchTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self.searchTextField setKeyboardType:UIKeyboardTypeDefault];
    [self.searchTextField setReturnKeyType:UIReturnKeySearch];
    [self.searchTextField setFont:[UIFont systemFontOfSize:12]];
    [self.searchTextField setPlaceholder:@"输入想搜索的游记,或旅行地点吧~"];
    [self addSubview:self.searchTextField];
    [_searchTextField release];
}

@end
