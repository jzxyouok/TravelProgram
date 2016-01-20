//
//  AreaPlanEnterCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaPlanEnterCell.h"
#import "AutoSize.h"
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
#import "PlanEnterTwo.h"
#import "CellTitleView.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#import "ClickImageView.h"
@interface AreaPlanEnterCell ()
/**
 *  描述的Label
 */
@property (nonatomic,retain)UILabel *descriptionFL;
/**
 *  图片view
 */
@property (nonatomic,retain)ClickImageView *picView;
/**
 *  titleView;
 */
@property (nonatomic,retain)CellTitleView *cellTitleView;
@property (nonatomic,retain)UIView *separatorView;

@end
@implementation AreaPlanEnterCell
- (void)dealloc
{
    [_separatorView release];
    [_cellTitleView release];
    [_picView release];
    [_cellContent release];
    [_descriptionFL release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor colorWithRed:0.8824 green:0.9059 blue:0.9333 alpha:1.0]];
        
        self.cellTitleView = [[CellTitleView alloc]init];
        [self.contentView addSubview:self.cellTitleView];
        [_cellTitleView release];
        
        self.picView = [[ClickImageView alloc]init];
        [self.picView setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:self.picView];
        [_picView release];
        
        self.descriptionFL = [[UILabel alloc]init];
        [self.descriptionFL setNumberOfLines:0];
        [self.descriptionFL setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:self.descriptionFL];
        [_descriptionFL release];
        
        self.separatorView = [[UIView alloc]init];
        [self.separatorView setBackgroundColor:[UIColor blackColor]];
        [self.contentView addSubview:self.separatorView];
        [_separatorView release];
    }
    return self;
}

+ (AreaPlanEnterCell *)areaPlanEnterCellWithTableView:(UITableView *)tableView{
    AreaPlanEnterCell *areaPlanEnterCell = [tableView dequeueReusableCellWithIdentifier:@"areaPlanEnterCell"];
    if (!areaPlanEnterCell) {
        areaPlanEnterCell = [[AreaPlanEnterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"areaPlanEnterCell"];
    }
    return areaPlanEnterCell;
}

- (void)setCellContent:(PlanEnterTwo *)cellContent{
    if (_cellContent != cellContent) {
        [_cellContent release];
        _cellContent = [cellContent retain];
        [self.picView setBackgroundColor:[UIColor whiteColor]];
        [self.picView sd_setImageWithURL:[NSURL URLWithString:_cellContent.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder"]];
        [self.descriptionFL setText:self.cellContent.tips];
        [self.cellTitleView setTitleViewContent:[_cellContent.position integerValue] andTitleText:_cellContent.entry_name];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat labelHeight = [AutoSize AutoSizeOfHeightWithText:self.cellContent.tips andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 20];
    CGFloat imageHeight = (kCellWidth - 20) * 0.57142;
    [self.cellTitleView setFrame:CGRectMake(10, 10, kCellWidth - 20, 20)];
    [self.picView setFrame:CGRectMake(10, 40, kCellWidth - 20, imageHeight)];
    [self.descriptionFL setFrame:CGRectMake(10, 50 + imageHeight, kCellWidth - 20, labelHeight)];
    [self.separatorView setFrame:CGRectMake(10, kCellHeight - 0.35, kCellWidth - 20, 0.7)];
}


@end
