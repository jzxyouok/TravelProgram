//
//  LeftViewTableViewCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/20.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "LeftViewTableViewCell.h"
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height

@interface LeftViewTableViewCell ()
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UIView *happyView;
@end
@implementation LeftViewTableViewCell
- (void)dealloc
{
    [_happyView release];
    [_titleLabel release];
    [_titleContent release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor blackColor]];
        
        self.happyView = [[UIView alloc]init];
        [self.happyView setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.happyView];
        [_happyView release];
        
        self.titleLabel = [[UILabel alloc]init];
        [self.titleLabel setTextColor:[UIColor whiteColor]];
        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
        [self.contentView addSubview:self.titleLabel];
        [_titleLabel release];
    }
    return self;
}
- (void)setTitleContent:(NSString *)titleContent{
    if (_titleContent != titleContent) {
        [_titleContent release];
        _titleContent = [titleContent copy];
        [self.titleLabel setText:_titleContent];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.happyView setFrame:CGRectMake(14, 13, 3,kCellHeight - 26)];
    [self.titleLabel setFrame:CGRectMake(20, 0, kCellWidth - 20, kCellHeight)];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
