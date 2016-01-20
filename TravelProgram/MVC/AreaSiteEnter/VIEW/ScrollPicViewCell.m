//
//  ScrollPicViewCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/18.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "ScrollPicViewCell.h"
#import "PhotoModel.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
@interface ScrollPicViewCell ()
@property (nonatomic,retain)UIImageView *picView;
@end
@implementation ScrollPicViewCell
- (void)dealloc
{
    [_picView release];
    [_photoModel release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.picView = [[UIImageView alloc]init];
        [self addSubview:self.picView];
        [_picView release];
    }
    return self;
}
- (void)setPhotoModel:(PhotoModel *)photoModel{
    if (_photoModel != photoModel) {
        [_photoModel release];
        _photoModel = [photoModel retain];
        [self.picView setBackgroundColor:[UIColor whiteColor]];
        [self.picView sd_setImageWithURL:[NSURL URLWithString:_photoModel.photo_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.picView setFrame:self.contentView.bounds];
}
@end
