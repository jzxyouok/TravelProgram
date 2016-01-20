//
//  AreaSiteEnterTitleView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaSiteEnterTitleView.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
#import "AreaSiteModel.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
@interface AreaSiteEnterTitleView ()
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UIImageView *sitePic;
@property (nonatomic,retain)UIImageView *shadowPic;

@end
@implementation AreaSiteEnterTitleView

- (void)dealloc
{
    [_sitePic release];
    [_shadowPic release];
    [_title release];
    [_blackView release];
    [_backGroundPic release];
    [_titileContent release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //创建自定义titleView
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
    [self.backGroundPic setImage:[UIImage imageNamed:@"placeHoder2"]];
    [self.backGroundPic setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:self.backGroundPic];
    [_backGroundPic release];
    //创建遮挡图片
    self.shadowPic = [[UIImageView alloc]init];
    [self.shadowPic setImage:[UIImage imageNamed:@"DestinationItemShadow@2x副本"]];
    [self.shadowPic setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:self.shadowPic];
    [_shadowPic release];
    //创建地点图标
    self.sitePic = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NodeIconAttraction48"]];
    [self.sitePic setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:self.sitePic];
    [_sitePic release];
    
    //创建标题Label
    self.title = [[UILabel alloc]init];
    [self.title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [self.title setTextColor:[UIColor whiteColor]];
    [self.title setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.title];
    [_title release];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backGroundPic setFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.shadowPic setFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.sitePic setFrame:CGRectMake(10, kHeight - 35, 30, 30)];
    [self.title setFrame:CGRectMake(45, kHeight - 35,kWidth - 30, 30)];
}

//获取到数据后赋值
- (void)setTitileContent:(AreaSiteModel *)titileContent{
    if (_titileContent != titileContent) {
        [_titileContent release];
        _titileContent = [titileContent retain];
        [self.backGroundPic setBackgroundColor:[UIColor whiteColor]];
        [self.backGroundPic sd_setImageWithURL:[NSURL URLWithString:_titileContent.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.title setText:_titileContent.name];
    }
}

@end
