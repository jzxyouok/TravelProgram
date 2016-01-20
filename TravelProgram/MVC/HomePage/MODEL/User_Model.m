//
//  User_Model.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "User_Model.h"

@implementation User_Model
- (void)dealloc
{
    [_image release];
    [_name release];
    [super dealloc];
}
@end
