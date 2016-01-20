//
//  PhotoModel.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "PhotoModel.h"

@implementation PhotoModel
- (void)dealloc
{
    [_photo_url release];
    [_height release];
    [_width release];
    [super dealloc];
}
@end
