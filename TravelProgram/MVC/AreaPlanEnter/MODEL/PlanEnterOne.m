//
//  PlanEnterOne.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "PlanEnterOne.h"
#import "PlanEnterTwo.h"
@implementation PlanEnterOne
- (void)dealloc
{
    [_memo release];
    [_oneArray release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"plan_nodes"]) {
        self.oneArray = [NSMutableArray array];
        for (NSDictionary *dic in (NSArray *)value) {
            PlanEnterTwo *two = [[PlanEnterTwo alloc]initWithDictionary:dic];
            [self.oneArray addObject:two];
            [two release];
        }
    }
}
@end
