//
//  PhotoCollectionViewCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "PhotoPageModel.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
@interface PhotoCollectionViewCell ()
@property (nonatomic,retain)UIImageView *picView;
@end
@implementation PhotoCollectionViewCell

- (void)dealloc
{
    [_picView release];
    [_cellContent release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.picView = [[UIImageView alloc]init];
        [self addSubview:self.picView];
        [_picView release];
    }
    return self;
}
- (void)setCellContent:(PhotoPageModel *)cellContent{
    if (_cellContent != cellContent) {
        [_cellContent release];
        _cellContent  = [cellContent retain];
        [self.picView setBackgroundColor:[UIColor whiteColor]];
        [self.picView sd_setImageWithURL:[NSURL URLWithString:_cellContent.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.picView setFrame:self.contentView.bounds];
}
@end
