//
//  Topic_Detail_CellTwo.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/13.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Topic_Detail_CellTwo.h"
#import "AutoSize.h"
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
#import "Topic_Detail_Model.h"
#import "Topic_Detail_Cell_TitleView.h"
@interface Topic_Detail_CellTwo ()
/**
 *  描述的Label
 */
@property (nonatomic,retain)UILabel *descriptionFL;
@property (nonatomic,retain)Topic_Detail_Cell_TitleView *cellTitleView;
@property (nonatomic,retain)UIView *separatorView;
@end

@implementation Topic_Detail_CellTwo
- (void)dealloc
{
    [_separatorView release];
    [_cellTitleView release];
    [_cellContent release];
    [_descriptionFL release];
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

+ (Topic_Detail_CellTwo *)topic_Detail_CellTwoWithTableView:(UITableView *)tableView{
    Topic_Detail_CellTwo *cellTwo = [tableView dequeueReusableCellWithIdentifier:@"topic_Detail_Cell_Two"];
    if (!cellTwo) {
        cellTwo = [[Topic_Detail_CellTwo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"topic_Detail_Cell_Two"];
    }
    return cellTwo;
}

- (void)setCellContent:(Topic_Detail_Model *)cellContent{
    if (_cellContent != cellContent) {
        [_cellContent release];
        _cellContent = [cellContent retain];
        [self.descriptionFL setText:self.cellContent.DescriptionMutable];
        self.cellTitleView.titleText = self.cellContent.title;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat labelHeight = [AutoSize AutoSizeOfHeightWithText:self.cellContent.DescriptionMutable andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 20];
    [self.cellTitleView setFrame:CGRectMake(10, 10, kCellWidth - 20, 20)];
    [self.descriptionFL setFrame:CGRectMake(10, 40, kCellWidth - 20, labelHeight)];
    [self.separatorView setFrame:CGRectMake(10, kCellHeight - 0.35, kCellWidth - 20, 0.7)];
}

@end
