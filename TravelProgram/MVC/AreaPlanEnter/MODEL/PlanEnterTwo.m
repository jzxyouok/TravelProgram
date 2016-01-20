//
//  PlanEnterTwo.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "PlanEnterTwo.h"

@implementation PlanEnterTwo
- (void)dealloc
{
    [_entry_id release];
    [_entry_name release];
    [_image_url release];
    [_lat release];
    [_lng release];
    [_tips release];
    [super dealloc];
}
@end
