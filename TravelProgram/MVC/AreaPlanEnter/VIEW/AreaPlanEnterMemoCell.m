//
//  AreaPlanEnterMemoCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaPlanEnterMemoCell.h"
#import "PlanEnterOne.h"
#import "AutoSize.h"
#import "Topic_Detail_Cell_TitleView.h"
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height

@interface AreaPlanEnterMemoCell ()
/**
 *  描述的Label
 */
@property (nonatomic,retain)UILabel *descriptionFL;
@property (nonatomic,retain)Topic_Detail_Cell_TitleView *cellTitleView;
@property (nonatomic,retain)UIView *separatorView;
@end
@implementation AreaPlanEnterMemoCell
- (void)dealloc
{
    [_descriptionFL release];
    [_cellTitleView release];
    [_separatorView release];
    [_memoCellContent release];
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
        
        self.cellTitleView = [[Topic_Detail_Cell_TitleView alloc]init];
        [self.contentView addSubview:self.cellTitleView];
        [_cellTitleView release];
        
        self.separatorView = [[UIView alloc]init];
        [self.separatorView setBackgroundColor:[UIColor blackColor]];
        [self.contentView addSubview:self.separatorView];
        [_separatorView release];
    }
    return self;
}

+ (AreaPlanEnterMemoCell *)areaPlanEnterMemoCellWithTableView:(UITableView *)tableView{
    AreaPlanEnterMemoCell *cellAreaPlanEnter = [tableView dequeueReusableCellWithIdentifier:@"cellAreaPlanEnter"];
    if (!cellAreaPlanEnter) {
        cellAreaPlanEnter = [[AreaPlanEnterMemoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellAreaPlanEnter"];
    }
    return cellAreaPlanEnter;
}
- (void)setMemoCellContent:(PlanEnterOne *)memoCellContent{
    if (_memoCellContent != memoCellContent) {
        [_memoCellContent release];
        _memoCellContent  = [memoCellContent retain];
        [self.descriptionFL setText:_memoCellContent.memo];
        self.cellTitleView.titleText = @"今日备忘";
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat labelHeight = [AutoSize AutoSizeOfHeightWithText:self.memoCellContent.memo andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 20];
    [self.cellTitleView setFrame:CGRectMake(10, 10, kCellWidth - 20, 20)];
    [self.descriptionFL setFrame:CGRectMake(10, 40, kCellWidth - 20, labelHeight)];
    [self.separatorView setFrame:CGRectMake(10, kCellHeight - 0.35, kCellWidth - 20, 0.7)];
}

@end
