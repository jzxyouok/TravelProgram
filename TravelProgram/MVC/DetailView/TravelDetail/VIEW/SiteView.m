//
//  SiteView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "SiteView.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
@interface SiteView ()
@property (nonatomic,retain)UIImageView *placeImageView;
@property (nonatomic,retain)UILabel *siteText;
@end
@implementation SiteView
- (void)dealloc
{
    [_labelText release];
    [_placeImageView release];
    [_siteText release];
    [super dealloc];
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.placeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NodeIconAttraction48"]];
        [self.placeImageView setContentMode:UIViewContentModeScaleToFill];
        
        [self addSubview:self.placeImageView];
        [_placeImageView release];
        
        self.siteText = [[UILabel alloc]init];
        [self addSubview:self.siteText];
        [_siteText release];
    }
    return self;
}
- (void)setLabelText:(NSString *)labelText{
    if (_labelText != labelText) {
        [_labelText release];
        _labelText = [labelText retain];
        [self.siteText setText:labelText];
    }
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.placeImageView setFrame:CGRectMake(10, 10, kHeight - 20, kHeight - 20)];
    [self.siteText setFrame:CGRectMake(kHeight, 0, kHeight * 4, kHeight)];
}
@end
