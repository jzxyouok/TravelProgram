//
//  Topic_Detail_TitleView.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/12.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Topic_Content;
@interface Topic_Detail_TitleView : UIView
@property (nonatomic,retain)Topic_Content *titilContent;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *subTitle;
@property (nonatomic,retain)UIImageView *shadowPic;
@property (nonatomic,retain)UIView *blackView;
@property (nonatomic,retain)UIImageView *backGroundPic;
@end
