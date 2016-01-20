//
//  Topic_Detail_CellThree.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/13.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Topic_Detail_CellThree.h"
#import "AutoSize.h"
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
#import "Topic_Detail_Model.h"
#import "Topic_Detail_Cell_ImageView.h"
@interface Topic_Detail_CellThree ()
/**
 *  描述的Label
 */
@property (nonatomic,retain)UILabel *descriptionFL;
@property (nonatomic,retain)Topic_Detail_Cell_ImageView *picView;
@property (nonatomic,retain)UIView *separatorView;
@end
@implementation Topic_Detail_CellThree
- (void)dealloc
{
    [_separatorView release];
    [_picView release];
    [_cellContent release];
    [_descriptionFL release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor colorWithRed:0.8824 green:0.9059 blue:0.9333 alpha:1.0]];
        self.picView = [[Topic_Detail_Cell_ImageView alloc]init];
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

+ (Topic_Detail_CellThree *)topic_Detail_CellThreeWithTableView:(UITableView *)tableView{
    Topic_Detail_CellThree *cellThree = [tableView dequeueReusableCellWithIdentifier:@"topic_Detail_Cell_Three"];
    if (!cellThree) {
        cellThree = [[Topic_Detail_CellThree alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"topic_Detail_Cell_Three"];
    }
    return cellThree;
}

- (void)setCellContent:(Topic_Detail_Model *)cellContent{
    if (_cellContent != cellContent) {
        [_cellContent release];
        _cellContent = [cellContent retain];
        [self.picView setImageViewContent:self.cellContent];
        [self.descriptionFL setText:self.cellContent.DescriptionMutable];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat labelHeight = [AutoSize AutoSizeOfHeightWithText:self.cellContent.DescriptionMutable andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 20];
    CGFloat imageHeight = (kCellWidth - 20) * ([self.cellContent.image_height floatValue] / [self.cellContent.image_width floatValue]);
    [self.picView setFrame:CGRectMake(10, 10, kCellWidth - 20, imageHeight)];
    [self.descriptionFL setFrame:CGRectMake(10, 20 + imageHeight, kCellWidth - 20, labelHeight)];
    [self.separatorView setFrame:CGRectMake(10, kCellHeight - 0.35, kCellWidth - 20, 0.7)];
}


@end
