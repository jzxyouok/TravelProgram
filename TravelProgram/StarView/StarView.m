//
//  StarView.m
//  StarView
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "StarView.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
@interface StarView ()
@property (nonatomic,assign)NSInteger starNumber;
@property (nonatomic,assign)NSInteger lightedNumber;
@end
@implementation StarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}
- (void)createStarWithNumber:(NSInteger)starNumber andLightedNumber:(NSInteger)lightedNumber{
    self.starNumber = starNumber;
    self.lightedNumber = lightedNumber;
    for (int i = 0 ; i < _starNumber; i++) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIImageView *starView = [[UIImageView alloc]init];
        [starView setContentMode:UIViewContentModeCenter];
        [starView setTag:12345 + i];
        [starView setImage:[UIImage imageNamed:@"star-1"]];
        [self addSubview:starView];
    }
    if (self.lightedNumber <= 4) {
        for (NSInteger i = self.lightedNumber; i < self.starNumber; i++) {
            [(UIImageView *)[self viewWithTag:12345 + i] setImage:[UIImage imageNamed:@"star-2"]];
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < _starNumber; i++) {
        [[self viewWithTag:12345 + i] setFrame:CGRectMake( i * (kWidth / _starNumber), 0, kWidth / _starNumber, kWidth / _starNumber)];
    }
}
@end
