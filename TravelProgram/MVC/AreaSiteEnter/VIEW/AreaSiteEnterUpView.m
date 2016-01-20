//
//  AreaSiteEnterUpView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaSiteEnterUpView.h"
#import "AreaSiteEnterModel.h"
#import "AutoSize.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
@interface AreaSiteEnterUpView ()
@property (nonatomic,retain)UILabel *travelLabel;
@property (nonatomic,retain)UILabel *mapLabel;
@property (nonatomic,retain)UILabel *photoLabel;
@property (nonatomic,retain)UILabel *introduce;
@property (nonatomic,retain)UIView *happyView;
@property (nonatomic,retain)UIView *happyViewTwo;
@property (nonatomic,assign)CGFloat introduceHeight;
@end
@implementation AreaSiteEnterUpView
- (void)dealloc
{
    [_happyView release];
    [_happyViewTwo release];
    [_travelLabel release];
    [_mapLabel release];
    [_photoLabel release];
    [_upViewContent release];
    [_goTravel release];
    [_goMap release];
    [_goPhoto release];
    [_introduce release];
    [super dealloc];
}
- (instancetype)init{
    [super init];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.8824 green:0.9059 blue:0.9333 alpha:1.0]];
        self.goPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.goPhoto setImage:[UIImage imageNamed:@"goToPhoto"] forState:UIControlStateNormal];
        [self addSubview:self.goPhoto];
        [_goPhoto release];
        
        self.photoLabel = [[UILabel alloc]init];
        [self.photoLabel setTextAlignment:NSTextAlignmentCenter];
        [self.photoLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:self.photoLabel];
        [_photoLabel release];
        
        self.happyView = [[UIView alloc]init];
        [self.happyView setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.happyView];
        [_happyView release];
        
        self.goTravel = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.goTravel setImage:[UIImage imageNamed:@"goToTravel"] forState:UIControlStateNormal];
        [self addSubview:self.goTravel];
        [_goTravel release];
        
        self.travelLabel = [[UILabel alloc]init];
        [self.travelLabel setTextAlignment:NSTextAlignmentCenter];
        [self.travelLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:self.travelLabel];
        [_travelLabel release];
        
        self.happyViewTwo = [[UIView alloc]init];
        [self.happyViewTwo setBackgroundColor:[UIColor redColor]];
        [self addSubview:self.happyViewTwo];
        [_happyViewTwo release];
        
        self.goMap = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.goMap setImage:[UIImage imageNamed:@"goToMap"] forState:UIControlStateNormal];
        [self addSubview:self.goMap];
        [_goMap release];
        
        self.mapLabel = [[UILabel alloc]init];
        [self.mapLabel setTextAlignment:NSTextAlignmentCenter];
        [self.mapLabel setText:@"地图"];
        [self.mapLabel setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:self.mapLabel];
        [_mapLabel release];
        
        self.introduce = [[UILabel alloc]init];
        [self.introduce setNumberOfLines:0];
        [self.introduce setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:self.introduce];
        [_introduce release];
    }
    return self;
}
- (void)setUpViewContent:(AreaSiteEnterModel *)upViewContent{
    if (_upViewContent != upViewContent) {
        [_upViewContent release];
        _upViewContent = [upViewContent retain];
        [self.travelLabel setText:[NSString stringWithFormat:@"%@篇游记",_upViewContent.attraction_trips_count]];
        [self.photoLabel setText:[NSString stringWithFormat:@"%@张照片",_upViewContent.photos_count]];
        [self.introduce setText:_upViewContent.descriptionFHY];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.introduceHeight = [AutoSize AutoSizeOfHeightWithText:_upViewContent.descriptionFHY andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth- 20];
    CGFloat down = kHeight - self.introduceHeight - 10;
    CGFloat width = kWidth / 3;
    [self.happyView setFrame:CGRectMake(width - 1, 25, 2, down - 50)];
    [self.happyViewTwo setFrame:CGRectMake(width * 2 - 1, 25, 2, down - 50)];
    [self.goPhoto setFrame:CGRectMake(width / 2 - 25, down / 2 - 25, 50, 30)];
    [self.photoLabel setFrame:CGRectMake(0, self.goPhoto.frame.origin.y + 32, width, 20)];
    [self.goTravel setFrame:CGRectMake(kWidth / 2 - 25, down / 2 - 25, 50, 30)];
    [self.travelLabel setFrame:CGRectMake(width, self.goTravel.frame.origin.y + 32, width, 20)];
    [self.goMap setFrame:CGRectMake((width * 2.5) - 25, down / 2 - 25, 50, 30)];
    [self.mapLabel setFrame:CGRectMake(width * 2, self.goMap.frame.origin.y + 32, width, 20)];
    [self.introduce setFrame:CGRectMake(10, down, kWidth - 20, self.introduceHeight)];

}
@end
