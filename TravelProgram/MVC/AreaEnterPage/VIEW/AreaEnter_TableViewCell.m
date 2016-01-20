
//
//  AreaEnter_TableViewCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/14.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaEnter_TableViewCell.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#import "AutoSize.h"
#import "AreaEnterModel.h"

#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height

@interface AreaEnter_TableViewCell ()
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *subTitle;
@property (nonatomic,retain)UIImageView *shadowPic;
@end
@implementation AreaEnter_TableViewCell
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
+ (AreaEnter_TableViewCell *)areaEnter_TableViewCellWithTableView:(UITableView *)tableView{
    static NSString *indentifier = @"areaEnter_TableViewCell";
    AreaEnter_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[AreaEnter_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
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
    [self.title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [self.title setTextColor:[UIColor whiteColor]];
    [self.title setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.title];
    [_title release];
    //创建子标题Label
    self.subTitle = [[UILabel alloc]init];
    [self.subTitle setFont:[UIFont systemFontOfSize:19]];
    [self.subTitle setTextColor:[UIColor whiteColor]];
    [self.subTitle setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.subTitle];
    [_subTitle release];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat zhNameWidth = [AutoSize AutoSizeOfWidthWithText:_content.name_zh_cn andFont:[UIFont systemFontOfSize:20] andLabelHeight:kCellHeight / 8];
    [self.backGroundPic setFrame:CGRectMake(0, 0, kCellWidth, kCellHeight)];
    [self.shadowPic setFrame:CGRectMake(0, 0, kCellWidth, kCellHeight)];
    [self.title setFrame:CGRectMake(10, kCellHeight - kCellHeight / 6, zhNameWidth, kCellHeight / 8)];
    [self.subTitle setFrame:CGRectMake(15 + zhNameWidth, self.title.frame.origin.y, kCellWidth - 10 - zhNameWidth, kCellHeight / 8)];
    
}

//获取到数据后赋值
- (void)setContent:(AreaEnterModel *)content{
    if (_content != content) {
        [_content release];
        _content = [content retain];
        [self.backGroundPic setBackgroundColor:[UIColor whiteColor]];
        [self.backGroundPic sd_setImageWithURL:[NSURL URLWithString:_content.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.title setText:content.name_zh_cn];
        [self.subTitle setText:content.name_en];
    }
}

@end
