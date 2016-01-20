//
//  CustomNavigationBar_Area.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSCustomNavigationBar.h"

@interface CustomNavigationBar_Area : BSCustomNavigationBar
/**
 *  搜索按钮
 */
@property (nonatomic,retain)UIButton *searchButton;
/**
 *  segment
 */
@property (nonatomic,retain)UIView *segment;
/**
 *  china按钮
 */
@property (nonatomic,retain)UIButton *china;
/**
 *  state按钮
 */
@property (nonatomic,retain)UIButton *otherCountry;


@property (nonatomic,retain)UIButton *myPageButton;
@end
