//
//  AreaPlanEnterTitleView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaPlanEnterTitleView.h"
#import "AreaPlanModel.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
@interface AreaPlanEnterTitleView ()
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *subTitle;
@property (nonatomic,retain)UIImageView *shadowPic;

@end
@implementation AreaPlanEnterTitleView
- (void)dealloc
{
    [_shadowPic release];
    [_title release];
    [_subTitle release];
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
    
    //创建标题Label
    self.title = [[UILabel alloc]init];
    [self.title setFont:[UIFont systemFontOfSize:18]];
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
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backGroundPic setFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.shadowPic setFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.title setFrame:CGRectMake(10,kHeight - 10 - (kHeight / 5), kWidth - 10, kHeight  / 9)];
    [self.subTitle setFrame:CGRectMake(10, self.title.frame.size.height + self.title.frame.origin.y, kWidth - 10, kHeight / 12)];
}

//获取到数据后赋值
- (void)setTitileContent:(AreaPlanModel *)titileContent{
    if (_titileContent != titileContent) {
        [_titileContent release];
        _titileContent = [titileContent retain];
        [self.backGroundPic setBackgroundColor:[UIColor whiteColor]];
        [self.backGroundPic sd_setImageWithURL:[NSURL URLWithString:_titileContent.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.title setText:_titileContent.name];
        [self.subTitle setText:[NSString stringWithFormat:@"%@天/%@个旅行地",_titileContent.plan_days_count,_titileContent.plan_nodes_count]];
    }
}

@end
