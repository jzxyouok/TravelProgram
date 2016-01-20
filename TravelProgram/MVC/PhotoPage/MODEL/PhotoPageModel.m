//
//  PhotoPageModel.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "PhotoPageModel.h"

@implementation PhotoPageModel
- (void)dealloc
{
    [_image_height release];
    [_image_url release];
    [_image_width release];
    [super dealloc];
}
@end
