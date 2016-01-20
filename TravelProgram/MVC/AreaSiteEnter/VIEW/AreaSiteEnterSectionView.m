//
//  AreaSiteEnterSectionView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaSiteEnterSectionView.h"

@interface AreaSiteEnterSectionView ()

@end
@implementation AreaSiteEnterSectionView

- (void)dealloc
{
    [_title release];
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
- (void)setTitle:(NSString *)title{
    if (_title != title) {
        [_title release];
        _title = [title retain];
        [self.contentLabel setText:_title];
    }
}



@end
