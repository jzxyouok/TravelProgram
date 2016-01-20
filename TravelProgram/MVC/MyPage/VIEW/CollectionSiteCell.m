//
//  CollectionSiteCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/22.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "CollectionSiteCell.h"
#import "AreaSiteModel.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
#import "StarView.h"
@interface CollectionSiteCell ()
@property (nonatomic,retain)UIImageView *picView;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *descriptionLabel;
@property (nonatomic,retain)StarView *starView;
@property (nonatomic,retain)UIView *separatorView;
@end
@implementation CollectionSiteCell
- (void)dealloc
{
    [_Content release];
    [_separatorView release];
    [_starView release];
    [_title release];
    [_descriptionLabel release];
    [_picView release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.8549 green:0.8824 blue:0.9176 alpha:1.0]];
        [self createSubViews];
    }
    return self;
}
- (void)createSubViews{
    [self.contentView setBackgroundColor:[UIColor colorWithRed:0.8549 green:0.8824 blue:0.9176 alpha:1.0]];
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
    [self.descriptionLabel setNumberOfLines:2];
    [self.descriptionLabel setFont:[UIFont systemFontOfSize:12]];
    [self.descriptionLabel setBackgroundColor:[UIColor colorWithRed:0.8549 green:0.8824 blue:0.9176 alpha:1.0]];
    [self.contentView addSubview:self.descriptionLabel];
    [_descriptionLabel release];
    self.separatorView = [[UIView alloc]init];
    [self.separatorView setBackgroundColor:[UIColor blackColor]];
    [self.contentView addSubview:self.separatorView];
    [_separatorView release];
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.picView setFrame:CGRectMake(5, 5, kCellHeight * 1.2, kCellHeight - 10)];
    [self.title setFrame:CGRectMake(kCellHeight * 1.2 + 10, 5, kCellWidth - kCellHeight * 1.2 - 20, 20)];
    [self.starView setFrame:CGRectMake(kCellHeight * 1.2 + 5, self.title.frame.size.height + self.title.frame.origin.y, kCellWidth - kCellHeight * 1.2 - 30 , (kCellWidth - kCellHeight * 1.2 - 30) / 10)];
    [self.descriptionLabel setFrame:CGRectMake(kCellHeight * 1.2 + 10, self.starView.frame.origin.y + self.starView.frame.size.height, kCellWidth - kCellHeight * 1.2 - 20, kCellHeight - self.starView.frame.size.height - self.starView.frame.origin.y)];
    [self.separatorView setFrame:CGRectMake(kCellHeight * 1.2 + 10, kCellHeight - 0.35, kCellWidth - kCellHeight * 1.2 - 20, 0.7)];
}

- (void)setContent:(AreaSiteModel *)Content{
    if (_Content != Content) {
        [_Content release];
        _Content = [Content retain];
        CGFloat lightedNumberF = [_Content.user_score floatValue];
        NSInteger lightedNumber =[_Content.user_score integerValue];
        if (lightedNumberF - lightedNumber > 0.5) {
            lightedNumber += 1;
        }
        [self.picView setBackgroundColor:[UIColor whiteColor]];
        [self.picView sd_setImageWithURL:[NSURL URLWithString:_Content.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.title setText:_Content.name];
        [self.starView createStarWithNumber:5 andLightedNumber:lightedNumber];
        [self.descriptionLabel setText:_Content.Description];
    }
}
@end
