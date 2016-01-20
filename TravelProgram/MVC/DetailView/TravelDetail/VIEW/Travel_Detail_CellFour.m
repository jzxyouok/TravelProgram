//
//  Travel_Detail_CellFour.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Travel_Detail_CellFour.h"
#import "Travel_Detail_TwoNotes.h"
#import "Photos.h"
#import "SiteView.h"
#import "AutoSize.h"
#import "ClickImageView.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
@interface Travel_Detail_CellFour ()
@property (nonatomic,retain)UILabel *descriptionFL;
@property (nonatomic,retain)ClickImageView *photo;
@property (nonatomic,retain)UIView *separatorView;
@end
@implementation Travel_Detail_CellFour

- (void)dealloc
{
    [_cellContent release];
    [_separatorView release];
    [_descriptionFL release];
    [_photo release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor colorWithRed:0.8824 green:0.9059 blue:0.9333 alpha:1.0]];
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

+ (Travel_Detail_CellFour *)travel_Detail_CellFourWithTableView:(UITableView *)tableView{
    Travel_Detail_CellFour *cellFour = [tableView dequeueReusableCellWithIdentifier:@"detail_Cell_Four"];
    if (!cellFour) {
        cellFour = [[Travel_Detail_CellFour alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detail_Cell_Four"];
    }
    return cellFour;
}

- (void)setCellContent:(Travel_Detail_TwoNotes *)cellContent{
    if (_cellContent != cellContent) {
        [_cellContent release];
        _cellContent = [cellContent retain];
        [self.descriptionFL setText:self.cellContent.descriptionF];
        [self.photo setBackgroundColor:[UIColor whiteColor]];
        [self.photo sd_setImageWithURL:[NSURL URLWithString:self.cellContent.photos.url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat labelHeight = [AutoSize AutoSizeOfHeightWithText:self.cellContent.descriptionF andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 20];
    CGFloat photoHeight = ([self.cellContent.photos.image_height floatValue] /[self.cellContent.photos.image_width floatValue]) * (kCellWidth - 20);
    [self.photo setFrame:CGRectMake(10, 10 , kCellWidth - 20, photoHeight)];
    [self.descriptionFL setFrame:CGRectMake(10, 10 + self.photo.frame.size.height + self.photo.frame.origin.y, kCellWidth - 20, labelHeight)];
    [self.separatorView setFrame:CGRectMake(10, kCellHeight - 0.35, kCellWidth - 20, 0.7)];
}



@end
