//
//  CellTitleView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "CellTitleView.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height

@interface CellTitleView ()@property (nonatomic,retain)UIImageView *placeImageView;
@property (nonatomic,retain)UILabel *titleLabel;

@end

@implementation CellTitleView
- (void)dealloc
{
    [_placeImageView release];
    [_titleLabel release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    [super initWithFrame:frame];
    if (self) {
        self.placeImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NodeIconAttraction48"]];
        [self.placeImageView setContentMode:UIViewContentModeScaleToFill];
        
        [self addSubview:self.placeImageView];
        [_placeImageView release];
        
        self.titleLabel = [[UILabel alloc]init];
        [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [self addSubview:self.titleLabel];
        [_titleLabel release];
  
    }
    return self;
}

- (void)setTitleViewContent:(NSInteger)rowNumber andTitleText:(NSString *)titleText{
    [self.titleLabel setText:[NSString stringWithFormat:@"第%ld站:%@",(long)rowNumber,titleText]];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self.placeImageView setFrame:CGRectMake(0, 0, kHeight, kHeight)];
    [self.titleLabel setFrame:CGRectMake(kHeight + 5, 1, kWidth - kHeight - 10, kHeight)];
}
@end
