//
//  Area_Collection_Header.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Area_Collection_Header.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
@interface Area_Collection_Header ()
@property (nonatomic,retain)UILabel *label;
@end
@implementation Area_Collection_Header
- (void)dealloc
{
    [_label release];
    [_headerContent release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self createLabel];
    }
    return self;
}
- (void)createLabel{
    self.label = [[UILabel alloc]init];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.label setTextColor:[UIColor whiteColor]];
    [self.label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [self addSubview:self.label];
    [_label release];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.label setFrame:CGRectMake(0 , 7, kWidth, 16)];
}

- (void)setHeaderContent:(NSString *)headerContent{
    if (_headerContent != headerContent) {
        [_headerContent release];
        _headerContent = [headerContent retain];
        [self.label setText:[NSString stringWithFormat:@"-- %@ --",headerContent]];
    }
}
@end
