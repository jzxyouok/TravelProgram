//
//  Home_TravelCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Home_TravelCell.h"
#import "Home_TravelContent.h"
#import "User_Model.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
@interface Home_TravelCell ()
@property (nonatomic,retain)UIImageView *backGroundPic;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *subTitle;
@property (nonatomic,retain)UIImageView *userImageView;
@property (nonatomic,retain)UIView *placeView;
@property (nonatomic,retain)UIImageView *shadowPic;
@end
@implementation Home_TravelCell
- (void)dealloc
{
    [_placeView release];
    [_shadowPic release];
    [_title release];
    [_subTitle release];
    [_userImageView release];
    [_backGroundPic release];
    [_content release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建cell上的子视图
        [self.contentView setBackgroundColor:[UIColor blackColor]];
        [self createSubViews];
    }
    return self;
}

+ (Home_TravelCell *)Home_TravelCellWithTableView:(UITableView *)tableView{
    static NSString *indentifier = @"Home_TravelCell";
    Home_TravelCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[Home_TravelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}
//创建cell上的子视图
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
    [self.shadowPic setImage:[UIImage imageNamed:@"DestinationItemShadow"]];
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
    //创建用户头像
    self.userImageView = [[UIImageView alloc]init];
    [self.userImageView setContentMode:UIViewContentModeScaleToFill];
    [self.userImageView.layer setMasksToBounds:YES];
    [self.contentView addSubview:self.userImageView];
    [_userImageView release];
    //创建间距条
    self.placeView = [[UIView alloc]init];
    [self.placeView setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:self.placeView];
    [_placeView release];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backGroundPic setFrame:CGRectMake(5, 0, kCellWidth - 10, kCellHeight-10)];
    [self.shadowPic setFrame:CGRectMake(5, 0, kCellWidth - 10, kCellHeight-10)];
    [self.title setFrame:CGRectMake(15, 5, kCellWidth - 30, kCellHeight  / 6)];
    [self.subTitle setFrame:CGRectMake(15, 5 + self.title.frame.size.height, kCellWidth - 30, kCellHeight / 12)];
    [self.userImageView setFrame:CGRectMake(15, kCellHeight - 20 - (kCellHeight / 5), kCellHeight / 5, kCellHeight / 5)];
    [self.userImageView.layer setCornerRadius:kCellHeight/10];
    [self.placeView setFrame:CGRectMake(0, kCellHeight - 10, kCellWidth, 10)];
    
}

//获取到数据后赋值
- (void)setContent:(Home_TravelContent *)content{
    if (_content != content) {
        [_content release];
        _content = [content retain];
        [self.backGroundPic setBackgroundColor:[UIColor blackColor]];
        [self.backGroundPic sd_setImageWithURL:[NSURL URLWithString:content.front_cover_photo_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.title setText:content.name];
        [self.subTitle setText:[NSString stringWithFormat:@"%@/%@天/%@图",content.start_date,content.days,content.photos_count]];
        [self.userImageView setBackgroundColor:[UIColor whiteColor]];
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:content.userModel.image] placeholderImage:[UIImage imageNamed:@"TripUserAvatarPlaceholder"]];
    }
}
@end
