//
//  Topic_Content.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Topic_Content.h"

@implementation Topic_Content
- (void)dealloc
{
    [_name release];
    [_title release];
    [_image_url release];
    [_distination_id release];
    [super dealloc];
}
@end
