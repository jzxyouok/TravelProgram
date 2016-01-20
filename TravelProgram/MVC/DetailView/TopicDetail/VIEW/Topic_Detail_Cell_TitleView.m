//
//  Topic_Detail_Cell_TitleView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/13.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Topic_Detail_Cell_TitleView.h"

@interface Topic_Detail_Cell_TitleView ()
@property (nonatomic,retain)UILabel *titleLabel;
@property (nonatomic,retain)UIView *happyView;
@end
@implementation Topic_Detail_Cell_TitleView
- (void)dealloc
{
    [_happyView release];
    [_titleLabel release];
    [_titleText release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.happyView = [[UIView alloc]init];
        [self.happyView setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.happyView];
        [_happyView release];
        
        self.titleLabel = [[UILabel alloc]init];
        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [self addSubview:self.titleLabel];
        [_titleLabel release];
    }
    return self;
}
- (void)setTitleText:(NSString *)titleText{
    if (_titleText != titleText) {
        [_titleText release];
        _titleText = [titleText retain];
        [self.titleLabel setText:_titleText];
    }
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame
     ];
    [self.happyView setFrame:CGRectMake(0, 3, 5, frame.size.height - 6)];
    [self.titleLabel setFrame:CGRectMake(10, 0, frame.size.width - 10, frame.size.height)];
}
@end
