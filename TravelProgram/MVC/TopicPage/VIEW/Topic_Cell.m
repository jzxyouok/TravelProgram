//
//  Topic_Cell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Topic_Cell.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
#import "Topic_Content.h"

@interface Topic_Cell ()
@property (nonatomic,retain)UIImageView *backGroundPic;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *subTitle;
@property (nonatomic,retain)UIView *placeView;
@property (nonatomic,retain)UIImageView *shadowPic;
@end
@implementation Topic_Cell
- (void)dealloc
{
    [_shadowPic release];
    [_title release];
    [_subTitle release];
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
+ (Topic_Cell *)topic_CellWithTableView:(UITableView *)tableView{
    static NSString *indentifier = @"Topic_Cell";
    Topic_Cell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[Topic_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}
//创建cell上的子视图
- (void)createSubViews{
    //创建背景图片
    self.backGroundPic = [[UIImageView alloc]init];
    [self.backGroundPic setImage:[UIImage imageNamed:@"placeHoder2"]];
    [self.backGroundPic setContentMode:UIViewContentModeScaleToFill];
    [self.contentView addSubview:self.backGroundPic];
    [_backGroundPic release];
    //创建遮挡图片
    self.shadowPic = [[UIImageView alloc]init];
    [self.shadowPic setImage:[UIImage imageNamed:@"DestinationItemShadow@2x副本"]];
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
    //创建间距条
    self.placeView = [[UIView alloc]init];
    [self.placeView setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:self.placeView];
    [_placeView release];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backGroundPic setFrame:CGRectMake(0, 0, kCellWidth, kCellHeight)];
    [self.shadowPic setFrame:CGRectMake(0, 0, kCellWidth, kCellHeight)];
    [self.title setFrame:CGRectMake(10, kCellHeight - 15 - (kCellHeight / 5), kCellWidth - 20, kCellHeight  / 8)];
    [self.subTitle setFrame:CGRectMake(10, self.title.frame.origin.y + self.title.frame.size.height, kCellWidth - 20, kCellHeight / 12)];
    
}

//获取到数据后赋值
- (void)setContent:(Topic_Content *)content{
    if (_content != content) {
        [_content release];
        _content = [content retain];
        [self.backGroundPic setBackgroundColor:[UIColor whiteColor]];
        [self.backGroundPic sd_setImageWithURL:[NSURL URLWithString:content.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.title setText:content.name];
        [self.subTitle setText:content.title];
    }
}


@end
