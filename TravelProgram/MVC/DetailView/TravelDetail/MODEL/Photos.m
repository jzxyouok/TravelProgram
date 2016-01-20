//
//  Photos.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Photos.h"

@implementation Photos
- (void)dealloc
{
    [_image_width release];
    [_image_height release];
    [_url release];
    [super dealloc];
}
@end
