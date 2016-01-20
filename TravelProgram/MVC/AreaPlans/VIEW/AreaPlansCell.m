//
//  AreaPlansCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/15.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaPlansCell.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#import "AreaPlanModel.h"
#import "AutoSize.h"
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
@interface AreaPlansCell ()
@property (nonatomic,retain)UIImageView *backGroundPic;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *subTitle;
@property (nonatomic,retain)UILabel *descriptionLabel;
@property (nonatomic,retain)UIImageView *shadowPic;
@end
@implementation AreaPlansCell
- (void)dealloc
{
    [_descriptionLabel release];
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

+ (AreaPlansCell *)areaPlansCellWithTableView:(UITableView *)tableView{
    static NSString *indentifier = @"areaPlansCell";
    AreaPlansCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[AreaPlansCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}
//创建cell上的子视图
- (void)createSubViews{
    //创建背景图片
    self.backGroundPic = [[UIImageView alloc]init];
    [self.backGroundPic setBackgroundColor:[UIColor lightGrayColor]];
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
    [self.subTitle setFont:[UIFont systemFontOfSize:13]];
    [self.subTitle setTextColor:[UIColor whiteColor]];
    [self.subTitle setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.subTitle];
    [_subTitle release];
    //创建描述条
    self.descriptionLabel = [[UILabel alloc]init];
    [self.descriptionLabel setNumberOfLines:0];
    [self.descriptionLabel setTextColor:[UIColor whiteColor]];
    [self.descriptionLabel setFont:[UIFont systemFontOfSize:14]];
    [self.descriptionLabel setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:self.descriptionLabel];
    [_descriptionLabel release];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat labelHeight = [AutoSize AutoSizeOfHeightWithText:[NSString stringWithFormat:@"\n%@\n",self.content.Description] andFont:[UIFont systemFontOfSize:14] andLabelWidth:kCellWidth - 16];
    [self.backGroundPic setFrame:CGRectMake(0, 0, kCellWidth, kCellWidth / 7 * 3)];
    [self.shadowPic setFrame:CGRectMake(0, 0, kCellWidth, kCellWidth / 7 * 3)];
    [self.title setFrame:CGRectMake(10, self.backGroundPic.frame.size.height - 42, kCellWidth - 20, 22)];
    [self.subTitle setFrame:CGRectMake(10, self.backGroundPic.frame.size.height - 22, kCellWidth - 20, 20)];\
    [self.descriptionLabel setFrame:CGRectMake(8, kCellWidth / 7 * 3, kCellWidth - 16, labelHeight)];
}

//获取到数据后赋值
- (void)setContent:(AreaPlanModel *)content{
    if (_content != content) {
        [_content release];
        _content = [content retain];
        [self.backGroundPic setBackgroundColor:[UIColor whiteColor]];
        [self.backGroundPic sd_setImageWithURL:[NSURL URLWithString:_content.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.title setText:content.name];
        [self.subTitle setText:[NSString stringWithFormat:@"%@天/%@个旅行地",_content.plan_days_count,_content.plan_nodes_count]];
        [self.descriptionLabel setText:[NSString stringWithFormat:@"\n%@\n",_content.Description]];
    }
}

@end
