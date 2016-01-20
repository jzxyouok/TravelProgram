//
//  CustomNavigationBar_Area.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "CustomNavigationBar_Area.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height

@interface CustomNavigationBar_Area ()
@end
@implementation CustomNavigationBar_Area

- (void)dealloc
{
    [_myPageButton release];
    [_china release];
    [_otherCountry release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        [self createMyButton];
        [self createSearchButton];
        [self createSegment];
    }
    return self;
}

- (void)createMyButton{
    self.myPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.myPageButton.adjustsImageWhenHighlighted = NO;
    [self.myPageButton setImage:[UIImage imageNamed:@"myButton"] forState:UIControlStateNormal];
    [self.myPageButton setTintColor:[UIColor whiteColor]];
    [self.myPageButton setFrame:CGRectMake(10, 20, 45, 45)];
    [self addSubview:self.myPageButton];
}
- (void)createSearchButton{
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.adjustsImageWhenHighlighted = NO;
    [self.searchButton setImage:[UIImage imageNamed:@"searchBtn"] forState:UIControlStateNormal];
    [self.searchButton setTintColor:[UIColor redColor]];
    [self.searchButton setFrame:CGRectMake(kWidth - 52, 20, 42, 42)];
    [self addSubview:self.searchButton];
}

- (void)createSegment{
    self.china = [UIButton buttonWithType:UIButtonTypeCustom];
    self.china.adjustsImageWhenHighlighted = NO;
    [self.china setImage:[UIImage imageNamed:@"nav_areaNormol"] forState:UIControlStateNormal];
    self.china.selected = NO;
    [self.china.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self.china setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.china setTitle:@" China" forState:UIControlStateNormal];
    [self.china setTintColor:[UIColor whiteColor]];
    [self.china setFrame:CGRectMake(kWidth / 2 + 10, 20, 75, 42)];
    [self addSubview:self.china];
    
    UIView *placeView = [[UIView alloc]initWithFrame:CGRectMake(kWidth / 2 - 2, 30, 2, 23)];
    [placeView setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:placeView];
    [placeView release];
    
    self.otherCountry = [UIButton buttonWithType:UIButtonTypeCustom];
    self.otherCountry.adjustsImageWhenHighlighted = NO;
    [self.otherCountry setImage:[UIImage imageNamed:@"nav_area2"] forState:UIControlStateNormal];
    [self.otherCountry.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [self.otherCountry setSelected:YES];
    [self.otherCountry setTitle:@" State" forState:UIControlStateNormal];
    [self.otherCountry setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.otherCountry setTintColor:[UIColor whiteColor]];
    [self.otherCountry setFrame:CGRectMake(kWidth / 2 - 90, 20, 75, 42)];
    [self addSubview:self.otherCountry];
}

@end
