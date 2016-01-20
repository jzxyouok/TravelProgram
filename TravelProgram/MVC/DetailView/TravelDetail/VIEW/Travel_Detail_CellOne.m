//
//  Travel_Detail_CellOne.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Travel_Detail_CellOne.h"
#import "Travel_Detail_TwoNotes.h"
#import "SiteView.h"
#import "AutoSize.h"
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
@interface Travel_Detail_CellOne ()
@property (nonatomic,retain)SiteView *siteView;
@property (nonatomic,retain)UILabel *descriptionFL;
@property (nonatomic,retain)UIView *separatorView;
@end
@implementation Travel_Detail_CellOne
- (void)dealloc
{
    [_cellContent release];
    [_separatorView release];
    [_siteView release];
    [_descriptionFL release];
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
        [self.descriptionFL setFont:[UIFont systemFontOfSize:15]];
        [self.descriptionFL setNumberOfLines:0];
        [self.contentView addSubview:self.descriptionFL];
        [_descriptionFL release];
        
        self.separatorView = [[UIView alloc]init];
        [self.separatorView setBackgroundColor:[UIColor blackColor]];
        [self.contentView addSubview:self.separatorView];
        [_separatorView release];
    }
    return self;
}

+ (Travel_Detail_CellOne *)travel_Detail_CellOneWithTableView:(UITableView *)tableView{
    Travel_Detail_CellOne *cellOne = [tableView dequeueReusableCellWithIdentifier:@"detail_Cell_One"];
    if (!cellOne) {
        cellOne = [[Travel_Detail_CellOne alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detail_Cell_One"];
    }
    return cellOne;
}

- (void)setCellContent:(Travel_Detail_TwoNotes *)cellContent{
    if (_cellContent != cellContent) {
        [_cellContent release];
        _cellContent = [cellContent retain];
        self.siteView.labelText = self.cellContent.zeroText;
        [self.descriptionFL setText:self.cellContent.descriptionF];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat labelHeight = [AutoSize AutoSizeOfHeightWithText:self.cellContent.descriptionF andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 20];
       [self.siteView setFrame:CGRectMake(0, 0, kCellWidth, 60)];
       [self.descriptionFL setFrame:CGRectMake(10, 10 + self.siteView.frame.size.height + self.siteView.frame.origin.y, kCellWidth - 20, labelHeight)];
    [self.separatorView setFrame:CGRectMake(10, kCellHeight - 0.35, kCellWidth - 20, 0.7)];
}

@end
