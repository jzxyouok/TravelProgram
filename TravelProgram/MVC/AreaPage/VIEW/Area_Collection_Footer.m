//
//  Area_Collection_Footer.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Area_Collection_Footer.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
@interface Area_Collection_Footer ()
@property (nonatomic,retain)UIImageView *end;
@end
@implementation Area_Collection_Footer

- (void)dealloc
{
    [_end release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.end = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"end"]];
        [self.end setTintColor:[UIColor whiteColor]];
        [self.end setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:self.end];
        [_end release];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.end setFrame:CGRectMake(kWidth / 2 - (kWidth / 14), 7.5, kWidth / 7, 30)];
}
@end
