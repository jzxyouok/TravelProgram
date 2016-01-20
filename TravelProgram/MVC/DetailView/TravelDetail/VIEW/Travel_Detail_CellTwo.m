//
//  Travel_Detail_CellTwo.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Travel_Detail_CellTwo.h"
#import "Travel_Detail_TwoNotes.h"
#import "Photos.h"
#import "SiteView.h"
#import "AutoSize.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#import "ClickImageView.h"
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
@interface Travel_Detail_CellTwo ()
@property (nonatomic,retain)SiteView *siteView;
@property (nonatomic,retain)UILabel *descriptionFL;
@property (nonatomic,retain)ClickImageView *photo;
@property (nonatomic,retain)UIView *separatorView;
@end
@implementation Travel_Detail_CellTwo

- (void)dealloc
{
    [_cellContent release];
    [_separatorView release];
    [_siteView release];
    [_descriptionFL release];
    [_photo release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor colorWithRed:0.8824 green:0.9059 blue:0.9333 alpha:1.0]];
        self.siteView = [[SiteView alloc]init];
        [self.contentView addSubview:self.siteView];
        [_siteView release];
        
        self.descriptionFL = [[UILabel alloc]init];
        [self.descriptionFL setNumberOfLines:0];
        [self.descriptionFL setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:self.descriptionFL];
        [_descriptionFL release];
        
        self.photo = [[ClickImageView alloc]init];
        [self.photo setContentMode:UIViewContentModeScaleToFill];
        [self.contentView addSubview:self.photo];
        [_photo release];
        
        self.separatorView = [[UIView alloc]init];
        [self.separatorView setBackgroundColor:[UIColor blackColor]];
        [self.contentView addSubview:self.separatorView];
        [_separatorView release];
        
    }
    return self;
}

+ (Travel_Detail_CellTwo *)travel_Detail_CellTwoWithTableView:(UITableView *)tableView{
    Travel_Detail_CellTwo *cellTwo = [tableView dequeueReusableCellWithIdentifier:@"detail_Cell_Two"];
    if (!cellTwo) {
        cellTwo = [[Travel_Detail_CellTwo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detail_Cell_Two"];
    }
    return cellTwo;
}

- (void)setCellContent:(Travel_Detail_TwoNotes *)cellContent{
    if (_cellContent != cellContent) {
        [_cellContent release];
        _cellContent = [cellContent retain];
        self.siteView.labelText = self.cellContent.zeroText;
        [self.descriptionFL setText:self.cellContent.descriptionF];
        [self.photo setBackgroundColor:[UIColor whiteColor]];
        [self.photo sd_setImageWithURL:[NSURL URLWithString:self.cellContent.photos.url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat labelHeight = [AutoSize AutoSizeOfHeightWithText:self.cellContent.descriptionF andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 20];
    CGFloat photoHeight = [self.cellContent.photos.image_height floatValue] / [self.cellContent.photos.image_width floatValue] * (kCellWidth - 20);
    [self.siteView setFrame:CGRectMake(0, 0, kCellWidth, 60)];
    [self.photo setFrame:CGRectMake(10, 10 + self.siteView.frame.size.height + self.siteView.frame.origin.y, kCellWidth - 20, photoHeight)];
    [self.descriptionFL setFrame:CGRectMake(10, 10 + self.photo.frame.size.height + self.photo.frame.origin.y, kCellWidth - 20, labelHeight)];
    [self.separatorView setFrame:CGRectMake(10, kCellHeight - 0.35, kCellWidth - 20, 0.7)];
}

@end
