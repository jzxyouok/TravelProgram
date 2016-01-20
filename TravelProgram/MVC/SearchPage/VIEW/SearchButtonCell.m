//
//  SearchButtonCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "SearchButtonCell.h"

@interface SearchButtonCell ()
@property (nonatomic,retain)UILabel *nameLabel;
@end

@implementation SearchButtonCell
- (void)dealloc
{
    [_cellLabelText release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.nameLabel.layer.borderWidth = 0.5;
        [self.nameLabel.layer setMasksToBounds:YES];
        [self.nameLabel.layer setCornerRadius:frame.size.height / 10];
        self.nameLabel.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self.nameLabel setFont:[UIFont systemFontOfSize:14]];
        [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
        [self.nameLabel setBackgroundColor:[UIColor colorWithRed:0.8784 green:0.9059 blue:0.9373 alpha:1.0]];
        [self.contentView addSubview:self.nameLabel];
        [_nameLabel release];
    }
    return self;
}
- (void)setCellLabelText:(NSString *)cellLabelText{
    if (_cellLabelText != cellLabelText) {
        [_cellLabelText release];
        _cellLabelText = [cellLabelText copy];
        [self.nameLabel setText:_cellLabelText];
    }
}
@end
