//
//  AreaEnterModel.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/14.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaEnterModel.h"

@implementation AreaEnterModel
- (void)dealloc
{
    [_image_url release];
    [_name_en release];
    [_name_zh_cn release];
    [super dealloc];
}

@end
