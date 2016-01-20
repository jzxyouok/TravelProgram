//
//  Area_CollectionCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Area_CollectionCell.h"
#import "Area_DestinationsModel.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height

@interface Area_CollectionCell ()
@property (nonatomic,retain)UIImageView *backGroundPic;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *subTitle;
@property (nonatomic,retain)UILabel *poiShadowPic;
@property (nonatomic,retain)UILabel *poi_countLabel;
@property (nonatomic,retain)UIImageView *shadowPic;
@end
@implementation Area_CollectionCell
- (void)dealloc
{
    [_poiShadowPic release];
    [_shadowPic release];
    [_title release];
    [_subTitle release];
    [_poi_countLabel release];
    [_backGroundPic release];
    [_content release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews{
    //创建背景图片
    self.backGroundPic = [[UIImageView alloc]init];
    //    [self.backGroundPic.layer setMasksToBounds:YES];
    [self.backGroundPic setImage:[UIImage imageNamed:@"placeHoder2"]];
    [self.backGroundPic setContentMode:UIViewContentModeScaleToFill];
    [self.contentView addSubview:self.backGroundPic];
    [_backGroundPic release];
    //创建遮挡图片
    self.shadowPic = [[UIImageView alloc]init];
    [self.shadowPic setImage:[UIImage imageNamed:@"DestinationItemShadow@2x副本"]];
    //    [self.shadowPic.layer setMasksToBounds:YES];
    [self.shadowPic setContentMode:UIViewContentModeScaleToFill];
    [self.contentView addSubview:self.shadowPic];
    [_shadowPic release];
    //创建标题Label
    self.title = [[UILabel alloc]init];
    [self.title setFont:[UIFont systemFontOfSize:20]];
    [self.title setTextColor:[UIColor whiteColor]];
    [self.title setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.title];
    [_title release];
    //创建子标题Label
    self.subTitle = [[UILabel alloc]init];
    [self.subTitle setFont:[UIFont systemFontOfSize:13]];
    [self.subTitle setTextColor:[UIColor whiteColor]];
    [self.subTitle setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.subTitle];
    [_subTitle release];
    //旅行地遮挡label
    self.poiShadowPic = [[UILabel alloc]init];
    [self.poiShadowPic setBackgroundColor:[UIColor blackColor]];
    [self.poiShadowPic setAlpha:0.5];
    [self.contentView addSubview:self.poiShadowPic];
    [_poiShadowPic release];
    //创建旅行地数目Label
    self.poi_countLabel = [[UILabel alloc]init];
    [self.poi_countLabel setTextAlignment:NSTextAlignmentCenter];
    [self.poi_countLabel setFont:[UIFont systemFontOfSize:13]];
    [self.poi_countLabel setTextColor:[UIColor whiteColor]];
    [self.poi_countLabel setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.poi_countLabel];
    [_poi_countLabel release];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.backGroundPic setFrame:CGRectMake(0, 0, kCellWidth, kCellHeight)];
    [self.shadowPic setFrame:CGRectMake(0, 0, kCellWidth, kCellHeight)];
    [self.title setFrame:CGRectMake(10, kCellHeight - 15 - (kCellHeight / 5), kCellWidth - 20, kCellHeight  / 8)];
    [self.subTitle setFrame:CGRectMake(10, self.title.frame.origin.y + self.title.frame.size.height, kCellWidth - 20, kCellHeight / 12)];
    [self.poiShadowPic setFrame:CGRectMake(kCellWidth / 2 - 5, 10, kCellWidth / 2 , kCellHeight / 12)];
    [self.poiShadowPic.layer setMasksToBounds:YES];
    [self.poiShadowPic.layer setCornerRadius:kCellWidth / 24];
    [self.poi_countLabel setFrame:CGRectMake(0, 0, kCellWidth / 2 , kCellHeight / 12 )];
    [self.poi_countLabel setCenter:self.poiShadowPic.center];
}
- (void)setContent:(Area_DestinationsModel *)content{
    if (_content != content) {
        [_content release];
        _content = [content retain];
        [self.backGroundPic setBackgroundColor:[UIColor whiteColor]];
        [self.backGroundPic sd_setImageWithURL:[NSURL URLWithString:content.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.title setText:content.name_zh_cn];
        [self.subTitle setText:content.name_en];
        [self.poi_countLabel setText:[NSString stringWithFormat:@"旅行地:%@",content.poi_countF]];
    }
}
@end
