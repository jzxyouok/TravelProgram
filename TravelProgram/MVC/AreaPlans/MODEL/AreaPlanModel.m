//
//  AreaPlanModel.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/15.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaPlanModel.h"

@implementation AreaPlanModel
- (void)dealloc
{
    [_Description release];
    [_image_url release];
    [_name release];
    [_plan_days_count release];
    [_plan_nodes_count release];
    [super dealloc];
}
@end
