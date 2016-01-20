//
//  Travel_Detail_Model.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Travel_Detail_Model.h"
#import "Travel_Detail_OneNotes.h"
@implementation Travel_Detail_Model
- (void)dealloc
{
    [_day release];
    [_trip_date release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"nodes"]) {
        for (NSDictionary *dic in (NSArray *)value) {
            Travel_Detail_OneNotes *oneNote = [[Travel_Detail_OneNotes alloc]initWithDictionary:dic];
            [self.notess addObject:oneNote];
            [oneNote release];
        }
    }
}

- (NSMutableArray *)notess{
    if (_nodess == nil) {
        _nodess = [NSMutableArray array];
    }
    return _nodess;
}
@end
