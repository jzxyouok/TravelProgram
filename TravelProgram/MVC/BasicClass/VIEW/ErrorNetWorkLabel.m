//
//  ErrorNetWorkLabel.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/14.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "ErrorNetWorkLabel.h"

@implementation ErrorNetWorkLabel
- (void)dealloc
{
    [_errorLabel release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        blackView.layer.masksToBounds = YES;
        [blackView.layer setCornerRadius:frame.size.height / 10];
        [blackView setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:0.5]];
        [self addSubview:blackView];
        
        self.errorLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.errorLabel setText:@"网络连接出现错误,请检查网络设置后重试"];
        [self.errorLabel setFont:[UIFont systemFontOfSize:12]];
        [self.errorLabel setTextAlignment:NSTextAlignmentCenter];
        [self.errorLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:self.errorLabel];
        [_errorLabel release];
    }
    return self;
}

@end
