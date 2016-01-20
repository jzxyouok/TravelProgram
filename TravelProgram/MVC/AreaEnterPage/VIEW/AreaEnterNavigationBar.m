//
//  AreaEnterNavigationBar.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/14.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaEnterNavigationBar.h"

@implementation AreaEnterNavigationBar
- (void)dealloc
{
    [_backButton release];
    [_titleView release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        self.titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, frame.size.width, 64 - 20)];
        [self.titleView setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        [self.titleView setTextColor:[UIColor whiteColor]];
        [self.titleView setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleView];
        [_titleView release];
        //创建自定义NavBar
        [self createBackButton];
    }
    return self;
}
//创建自定义NavBar
- (void)createBackButton{
    //创建返回键
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setFrame:CGRectMake(10, 20, 44, 44)];
    [self.backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [self.backButton setTintColor:[UIColor whiteColor]];
    [self.backButton setImage:[UIImage imageNamed:@"nav_back_two"] forState:UIControlStateHighlighted];
    [self addSubview:self.backButton];
}
@end
