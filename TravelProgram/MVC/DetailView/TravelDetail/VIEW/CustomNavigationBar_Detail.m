//
//  CustomNavigationBar_Detail.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "CustomNavigationBar_Detail.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
#import "Home_TravelContent.h"
#import "User_Model.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
@interface CustomNavigationBar_Detail ()
@end
@implementation CustomNavigationBar_Detail
- (void)dealloc
{
    [_shareButton release];
    [_collectionButton release];
    [_titleView release];
    [_backButton release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.titleView = [[UILabel alloc]initWithFrame:CGRectMake(55, 20, frame.size.width - 55 - 98, 64 - 20)];
        [self.titleView setTextColor:[UIColor whiteColor]];
        [self.titleView setAlpha:0];
        [self.titleView setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.titleView];
        [_titleView release];
        //创建自定义NavBar
        [self createBackButton];
        [self createShareButton];
        [self createCollectionButton];
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
- (void)createShareButton{
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shareButton setImage:[UIImage imageNamed:@"nav_col_1"] forState:UIControlStateNormal];
    [self.shareButton setTintColor:[UIColor whiteColor]];
    [self.shareButton setImage:[UIImage imageNamed:@"nav_col_2"] forState:UIControlStateHighlighted];
    [self addSubview:self.shareButton];
}
- (void)createCollectionButton{
    self.collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.collectionButton setTintColor:[UIColor whiteColor]];
    [self addSubview:self.collectionButton];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.shareButton setFrame:CGRectMake(kWidth -  49 , 20, 44, 44)];
    [self.collectionButton setFrame:CGRectMake(kWidth - 98, 20, 44, 44)];
}
@end
