//
//  AreaSiteModel.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaSiteModel.h"

@implementation AreaSiteModel
- (void)dealloc
{
    [_Description release];
    [_image_url release];
    [_name release];
    [_user_score release];
    [super dealloc];
}
@end
