//
//  Annotation.m
//  MapDemo
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
- (void)dealloc
{
    [_title release];
    [super dealloc];
}
@end
