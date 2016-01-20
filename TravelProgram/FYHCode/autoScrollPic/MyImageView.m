//
//  MyImageView.m
//  轮播图
//
//  Created by 付寒宇 on 15/9/21.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "MyImageView.h"
#import "Home_TravelContent.h"
#import "User_Model.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageManager.h>
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
@implementation MyImageView
- (void)dealloc
{
    [_placeView release];
    [_shadowPic release];
    [_title release];
    [_subTitle release];
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
//创建view上的子视图
- (void)createSubViews{
    //创建背景图片
    self.backGroundPic = [[UIImageView alloc]init];
    [self.backGroundPic.layer setMasksToBounds:YES];
    [self.backGroundPic setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:self.backGroundPic];
    [_backGroundPic release];
    //创建遮挡图片
    self.shadowPic = [[UIImageView alloc]init];
    [self.shadowPic setImage:[UIImage imageNamed:@"DestinationItemShadow@2x副本"]];
    [self.shadowPic.layer setMasksToBounds:YES];
    [self.shadowPic setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:self.shadowPic];
    [_shadowPic release];
    //创建标题Label
    self.title = [[UILabel alloc]init];
    [self.title setFont:[UIFont systemFontOfSize:20]];
    [self.title setTextColor:[UIColor whiteColor]];
    [self.title setTextAlignment:NSTextAlignmentRight];
    [self.title setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.title];
    [_title release];
    //创建子标题Label
    self.subTitle = [[UILabel alloc]init];
    [self.subTitle setFont:[UIFont systemFontOfSize:13]];
    [self.subTitle setTextColor:[UIColor whiteColor]];
    [self.subTitle setTextAlignment:NSTextAlignmentRight];
    [self.subTitle setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.subTitle];
    [_subTitle release];
    //创建间距条
    self.placeView = [[UIView alloc]init];
    [self.placeView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:self.placeView];
    [_placeView release];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.backGroundPic setFrame:CGRectMake(0, 0, kWidth, kHeight-10)];
    [self.shadowPic setFrame:CGRectMake(0, 0, kWidth, kHeight-10)];
    [self.title setFrame:CGRectMake(10, kHeight - 30 - (kHeight / 5), kWidth - 20, kHeight  / 6)];
    [self.subTitle setFrame:CGRectMake(10, 5 + self.title.frame.origin.y + self.title.frame.size.height, kWidth - 20, kHeight / 12)];
    [self.placeView setFrame:CGRectMake(0, kHeight - 10, kWidth, 10)];
}


- (void)setContent:(Home_TravelContent *)content{
    if (_content != content) {
        [_content release];
        _content = [content retain];
        [self.backGroundPic setBackgroundColor:[UIColor whiteColor]];
        [self.backGroundPic sd_setImageWithURL:[NSURL URLWithString:content.front_cover_photo_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.title setText:content.name];
        [self.subTitle setText:[NSString stringWithFormat:@"%@/%@天/%@图",content.start_date,content.days,content.photos_count]];
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_delegate touchBegin];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_delegate touchLeft];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
