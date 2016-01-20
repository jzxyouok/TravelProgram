//
//  AreaSiteCollectionViewCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaSiteModel.h"
#import "AreaSiteCollectionViewCell.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
#import "AutoSize.h"
#import "StarView.h"
@interface AreaSiteCollectionViewCell ()
@property (nonatomic,retain)UIImageView *picView;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *descriptionLabel;
@property (nonatomic,retain)StarView *starView;
@end
@implementation AreaSiteCollectionViewCell
- (void)dealloc
{
    [_starView release];
    [_title release];
    [_descriptionLabel release];
    [_picView release];
    [_cellContent release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.8549 green:0.8824 blue:0.9176 alpha:1.0]];
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews{
    //创建背景图片
    self.picView = [[UIImageView alloc]init];
    [self.picView.layer setMasksToBounds:YES];
    [self.picView setContentMode:UIViewContentModeScaleToFill];
    [self.contentView addSubview:self.picView];
    [_picView release];
    //创建标题Label
    self.title = [[UILabel alloc]init];
    [self.title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [self.title setBackgroundColor:[UIColor colorWithRed:0.8549 green:0.8824 blue:0.9176 alpha:1.0]];
    [self.contentView addSubview:self.title];
    [_title release];
    //创建starView
    self.starView = [[StarView alloc]init];
    [self.starView setBackgroundColor:[UIColor colorWithRed:0.8549 green:0.8824 blue:0.9176 alpha:1.0]];
    [self.contentView addSubview:self.starView];
    [_starView release];
    //创建描述Label
    self.descriptionLabel = [[UILabel alloc]init];
    [self.descriptionLabel setNumberOfLines:0];
    [self.descriptionLabel setFont:[UIFont systemFontOfSize:12]];
    [self.descriptionLabel setBackgroundColor:[UIColor colorWithRed:0.8549 green:0.8824 blue:0.9176 alpha:1.0]];
    [self.contentView addSubview:self.descriptionLabel];
    [_descriptionLabel release];

    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat descriptionHeight = [AutoSize AutoSizeOfHeightWithText:_cellContent.Description andFont:[UIFont systemFontOfSize:12] andLabelWidth:kCellWidth];
    [self.picView setFrame:CGRectMake(0, 0, kCellWidth, kCellWidth * 0.6)];
    [self.title setFrame:CGRectMake(0, self.picView.frame.size.height, kCellWidth, 20)];
    [self.starView setFrame:CGRectMake(0, self.title.frame.size.height + self.title.frame.origin.y, kCellWidth , kCellWidth / 10)];
    [self.descriptionLabel setFrame:CGRectMake(0, self.starView.frame.origin.y + self.starView.frame.size.height, kCellWidth, descriptionHeight)];
}

- (void)setCellContent:(AreaSiteModel *)cellContent{
    if (_cellContent != cellContent) {
        [_cellContent release];
        _cellContent = [cellContent retain];
        CGFloat lightedNumberF = [_cellContent.user_score floatValue];
        NSInteger lightedNumber =[_cellContent.user_score integerValue];
        if (lightedNumberF - lightedNumber > 0.5) {
            lightedNumber += 1;
        }
        [self.picView setBackgroundColor:[UIColor whiteColor]];
        [self.picView sd_setImageWithURL:[NSURL URLWithString:_cellContent.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.title setText:_cellContent.name];
        [self.starView createStarWithNumber:5 andLightedNumber:lightedNumber];
        [self.descriptionLabel setText:_cellContent.Description];
    }
}
@end
