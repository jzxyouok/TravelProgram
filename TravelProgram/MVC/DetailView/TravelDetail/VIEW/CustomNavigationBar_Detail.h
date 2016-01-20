//
//  CustomNavigationBar_Detail.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSCustomNavigationBar.h"
@interface CustomNavigationBar_Detail : BSCustomNavigationBar
/**
 *  返回按钮
 */
@property (nonatomic,retain)UIButton *backButton;
/**
 *  分享按钮
 */
@property (nonatomic,retain)UIButton *shareButton;
/**
 *  收藏按钮
 */
@property (nonatomic,retain)UIButton *collectionButton;
@property (nonatomic,retain)UILabel *titleView;
@end
