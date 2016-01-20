//
//  EnterView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/15.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
#import "EnterView.h"
#import "AreaEnterModel.h"
#import <UIImageView+WebCache.h>
#import <SDWebImageManager.h>
@interface EnterView ()
@property (nonatomic,retain)UIButton *backButton;
@property (nonatomic,retain)UILabel *nameLabel;
@property (nonatomic,retain)UIImageView *imageView;
@end
@implementation EnterView
- (void)dealloc
{
    [_imageView release];
    [_nameLabel release];
    [_viewContent release];
    [super dealloc];
}
- (instancetype)initWithEffect:(UIVisualEffect *)effect{
    self = [super initWithEffect:effect];
    if (self) {
        [self createBackBtn];
        [self createNameLabel];
        [self createImageView];
    }
    return self;
}
- (void)createBackBtn{
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setFrame:CGRectMake(10, 20, 44, 44)];
    [self.backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [self.backButton setTintColor:[UIColor whiteColor]];
    [self.backButton setImage:[UIImage imageNamed:@"nav_back_two"] forState:UIControlStateHighlighted];
    [self.backButton addTarget:self action:@selector(touchBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    NSArray *imageNameArr = @[@"areaEnter_1",@"areaEnter_2",@"areaEnter_3",@"areaEnter_4"];
    NSArray *labelNameArr = @[@"行程",@"游记",@"旅行地",@"专题"];
    for (int i = 0 ; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:3000 + i];
        [btn addTarget:self
                action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:imageNameArr[i]] forState:UIControlStateNormal];
        [self addSubview:btn];
        UILabel *btnLabel = [[UILabel alloc]init];
        [btnLabel setTag:3100 + i];
        [btnLabel setText:labelNameArr[i]];
        [btnLabel setTextAlignment:NSTextAlignmentCenter];
        [btnLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:btnLabel];
    }
}
- (void)createImageView{
    self.imageView = [[UIImageView alloc]init];
    [self addSubview:self.imageView];
    [_imageView release];
}
//返回即是去除
- (void)touchBackButton{
    [self removeFromSuperview];
}
- (void)createNameLabel{
    self.nameLabel = [[UILabel alloc]init];
    [self.nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:35]];
    [self.nameLabel setTextColor:[UIColor whiteColor]];
    [self.nameLabel setNumberOfLines:2];
    [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
    //文本阴影颜色
    self.nameLabel.shadowColor = [UIColor blackColor];
    //阴影大小
    self.nameLabel.shadowOffset = CGSizeMake(2, 2);
    [self addSubview:self.nameLabel];
    [_nameLabel release];
}
//开始动画
- (void)starShow{
        [UIView animateWithDuration:1 animations:^{
            [self.nameLabel setFrame:CGRectMake(0, 64, kWidth, kHeight / 8)];
            [self.imageView setFrame:CGRectMake(0, _nameLabel.frame.size.height + _nameLabel.frame.origin.y + 40, kWidth, kHeight / 3)];
            CGFloat btnLong = (kWidth - 30 * 2 - 30 * 3) / 4;
            for (int i = 0; i < 4; i++) {
                UIButton *btn = (UIButton *)[self viewWithTag:(3000 + i)];
                UILabel *btnLabel = (UILabel *)[self viewWithTag:(3100 + i)];
                [btn setFrame:CGRectMake(30 + i * (30 + btnLong), self.imageView.frame.origin.y + _imageView.frame.size.height + 30, btnLong, btnLong)];
                [btnLabel setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y + btnLong + 10, btn.frame.size.width, 22)];
            }
        }];
}
- (void)setViewContent:(AreaEnterModel *)viewContent{
    if (_viewContent != viewContent) {
        [_viewContent release];
        _viewContent = [viewContent retain];
        [self.nameLabel setText:[NSString stringWithFormat:@"%@\n%@",_viewContent.name_zh_cn,_viewContent.name_en]];
        [self.imageView setBackgroundColor:[UIColor whiteColor]];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:_viewContent.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
    }
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.nameLabel setFrame:CGRectMake(0, 64 + kHeight, kWidth, kHeight / 8)];
    [self.imageView setFrame:CGRectMake(0, _nameLabel.frame.size.height + _nameLabel.frame.origin.y + 40, kWidth, kHeight / 3)];
    CGFloat btnLong = (frame.size.width - 30 * 2 - 30 * 3) / 4;
    for (int i = 0; i < 4; i++) {
        UIButton *btn = (UIButton *)[self viewWithTag:(3000 + i)];
        UILabel *btnLabel = (UILabel *)[self viewWithTag:(3100 + i)];
        [btn setFrame:CGRectMake(30 + i * (30 + btnLong), self.imageView.frame.origin.y + _imageView.frame.size.height + 30, btnLong, btnLong)];
        [btnLabel setFrame:CGRectMake(btn.frame.origin.x, btn.frame.origin.y + btnLong + 10, btn.frame.size.width, 22)];
    }
}
- (void)push:(UIButton *)btn{
    [_delegate pushToPage:btn.tag andModel:self.viewContent];
}
@end
