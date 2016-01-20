//
//  Travel_Detail_TitleView.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Home_TravelContent;
@interface Travel_Detail_TitleView : UIView
/**
 *  自定义titleView上的内容
 */
@property (nonatomic,retain)Home_TravelContent *titilContent;
@property (nonatomic,retain)UIImageView *backGroundPic;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *subTitle;
@property (nonatomic,retain)UIImageView *userImageView;
@property (nonatomic,retain)UIImageView *shadowPic;
@property (nonatomic,retain)UIView *blackView;
@end
