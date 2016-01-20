//
//  Topic_Detail_Cell_ImageView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/13.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Topic_Detail_Cell_ImageView.h"
#import "Topic_Detail_Model.h"
#import "Topic_Detail_notes.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
#import "Topic_Content.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#import "ClickImageView.h"
@interface Topic_Detail_Cell_ImageView ()
@property (nonatomic,retain)ClickImageView *backGroundPic;
@property (nonatomic,retain)UILabel *userName;
@property (nonatomic,retain)UILabel *trip_name;
@end
@implementation Topic_Detail_Cell_ImageView
- (void)dealloc
{
    [_userName release];
    [_trip_name release];
    [_backGroundPic release];
    [_imageViewContent release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //创建视图
        [self createTitleView];
    }
    return self;
}
- (void)createTitleView{
    //创建背景图片
    self.backGroundPic = [[ClickImageView alloc]init];
    [self.backGroundPic setImage:[UIImage imageNamed:@"placeHoder2"]];
    [self.backGroundPic setContentMode:UIViewContentModeScaleToFill];
    [self addSubview:self.backGroundPic];
    [_backGroundPic release];
    
    //创建游记Label
    self.trip_name = [[UILabel alloc]init];
    [self.trip_name setFont:[UIFont systemFontOfSize:12]];
    [self.trip_name setTextColor:[UIColor whiteColor]];
    [self.trip_name setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.trip_name];
    [_trip_name release];
    //创建子标题Label
    self.userName = [[UILabel alloc]init];
    [self.userName setFont:[UIFont systemFontOfSize:12]];
    [self.userName setTextColor:[UIColor whiteColor]];
    [self.userName setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.userName];
    [_userName release];
}
- (void)layoutSubviews {
    [super layoutSubviews];

}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.backGroundPic setFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.userName setFrame:CGRectMake(10,kHeight - (kHeight / 5), kWidth - 10, kHeight  / 12)];
    [self.trip_name setFrame:CGRectMake(10, self.userName.frame.size.height + self.userName.frame.origin.y, kWidth - 10, kHeight / 12)];
}
//获取到数据后赋值
- (void)setImageViewContent:(Topic_Detail_Model *)imageViewContent{
    if (_imageViewContent != imageViewContent) {
        [_imageViewContent release];
        _imageViewContent = [imageViewContent retain];
        [self.backGroundPic setBackgroundColor:[UIColor whiteColor]];
        [self.backGroundPic sd_setImageWithURL:[NSURL URLWithString:_imageViewContent.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        [self.trip_name setText:_imageViewContent.topic_detail_notes.trip_name];
        if (_imageViewContent.topic_detail_notes.user_name) {
            [self.userName setText:[NSString stringWithFormat:@"@%@",_imageViewContent.topic_detail_notes.user_name]];
        }
    }
}


@end
