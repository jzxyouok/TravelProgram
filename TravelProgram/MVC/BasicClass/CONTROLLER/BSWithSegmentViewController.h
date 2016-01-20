//
//  BSWithSegmentViewController.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSViewController.h"
@class CustomNavigationBar_Area;
@interface BSWithSegmentViewController : BSViewController
@property (nonatomic,retain)CustomNavigationBar_Area *customNavigationBar;
- (void)searchAction:(UIButton *)btn;
- (void)state:(UIButton *)otherCountry;
- (void)china:(UIButton *)chinaBtn;
- (void)myPage:(UIButton *)myPageBtn;
@end
