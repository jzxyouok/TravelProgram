//
//  MyPageCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/22.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "MyPageCell.h"
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height

@interface MyPageCell ()
@end

@implementation MyPageCell
- (void)dealloc
{
    [_moreLabel release];
    [_contentLabel release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        self.contentLabel = [[UILabel alloc]init];
        [self.contentLabel setFont:[UIFont systemFontOfSize:14]];
        [self.contentView addSubview:self.contentLabel];
        [_contentLabel release];
        
        self.moreLabel = [[UILabel alloc]init];
        [self.moreLabel setTextAlignment:NSTextAlignmentRight];
        [self.moreLabel setFont:[UIFont systemFontOfSize:14]];
        [self.moreLabel setAlpha:0.5];
        [self.contentView addSubview:self.moreLabel];
        [_moreLabel release];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.moreLabel setFrame:CGRectMake(kCellWidth - 100,  0, 100, kCellHeight)];
    [self.contentLabel setFrame:CGRectMake(20, 0, kCellWidth - 20, kCellHeight)];
}
@end
