//
//  PlanEnterTableViewSectionHeaderView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "PlanEnterTableViewSectionHeaderView.h"

@interface PlanEnterTableViewSectionHeaderView ()
@property (nonatomic,retain)UILabel *contentLabel;
@end

@implementation PlanEnterTableViewSectionHeaderView

- (void)dealloc
{
    [_contentLabel release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentLabel = [[UILabel alloc]initWithFrame:frame];
        [self.contentLabel setBackgroundColor:[UIColor whiteColor]];
        [self.contentLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentLabel setTextColor:[UIColor blackColor]];
        [self.contentLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [self addSubview:self.contentLabel];
    }
    return self;
}
- (void)setSectionNumber:(NSInteger)sectionNumber{
    _sectionNumber = sectionNumber;
    [self.contentLabel setText:[NSString stringWithFormat:@"Day%ld",_sectionNumber + 1]];
}


@end
