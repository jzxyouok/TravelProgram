//
//  Travel_Detail_TitleView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Travel_Detail_TitleView.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
#import "Home_TravelContent.h"
#import "User_Model.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>

@interface Travel_Detail_TitleView ()

@end
@implementation Travel_Detail_TitleView
- (void)dealloc
{
    [_shadowPic release];
    [_title release];
    [_blackView release];
    [_subTitle release];
    [_userImageView release];
    [_backGroundPic release];
    [_titilContent release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //创建自定义NavBar
        [self createTitleView];
        
        self.blackView = [[UIView alloc]initWithFrame:frame];
        [self.blackView setBackgroundColor:[UIColor blackColor]];
        [self.blackView setAlpha:0];
        [self addSubview:self.blackView];
        [_blackView release];
    }
    return self;
}

- (void)createTitleView{
    //创建背景图片
    self.backGroundPic = [[UIImageView alloc]init];
    [self.backGroundPic setImage:[UIImage imageNamed:@"DestinationItemShadow@2x副本"]];
    [self.backGroundPic setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:self.backGroundPic];
    [_backGroundPic release];
    //创建遮挡图片
    self.shadowPic = [[UIImageView alloc]init];
    [self.shadowPic setImage:[UIImage imageNamed:@"DestinationItemShadow@2x副本"]];
    [self.shadowPic setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:self.shadowPic];
    [_shadowPic release];
    
    //创建标题Label
    self.title = [[UILabel alloc]init];
    [self.title setFont:[UIFont systemFontOfSize:15]];
    [self.title setTextColor:[UIColor whiteColor]];
    [self.title setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.title];
    [_title release];
    //创建子标题Label
    self.subTitle = [[UILabel alloc]init];
    [self.subTitle setFont:[UIFont systemFontOfSize:12]];
    [self.subTitle setTextColor:[UIColor whiteColor]];
    [self.subTitle setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.subTitle];
    [_subTitle release];
    //创建用户头像
    self.userImageView = [[UIImageView alloc]init];
    [self.userImageView setContentMode:UIViewContentModeScaleToFill];
    [self.userImageView.layer setMasksToBounds:YES];
    [self addSubview:self.userImageView];
    [_userImageView release];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backGroundPic setFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.shadowPic setFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.userImageView setFrame:CGRectMake(10, kHeight - 10 - (kHeight / 5), kHeight / 5, kHeight / 5)];
    [self.userImageView.layer setCornerRadius:kHeight/10];
    [self.title setFrame:CGRectMake(17 + self.userImageView.frame.size.width, self.userImageView.frame.origin.y, kWidth - 20, kHeight  / 9)];
    [self.subTitle setFrame:CGRectMake(17 + self.userImageView.frame.size.width, self.title.frame.size.height + self.title.frame.origin.y, kWidth - 20, kHeight / 12)];
}

//获取到数据后赋值
- (void)setTitilContent:(Home_TravelContent *)titilContent{
    if (_titilContent != titilContent) {
        [_titilContent release];
        _titilContent = [titilContent retain];
        [self.backGroundPic setBackgroundColor:[UIColor whiteColor]];
        [self.backGroundPic sd_setImageWithURL:[NSURL URLWithString:_titilContent.front_cover_photo_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.title setText:_titilContent.name];
        [self.subTitle setText:[NSString stringWithFormat:@"%@/%@天/%@图",_titilContent.start_date,_titilContent.days,_titilContent.photos_count]];
        [self.userImageView setBackgroundColor:[UIColor whiteColor]];
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:_titilContent.userModel.image] placeholderImage:[UIImage imageNamed:@"TripUserAvatarPlaceholder"]];
    }
}
@end
