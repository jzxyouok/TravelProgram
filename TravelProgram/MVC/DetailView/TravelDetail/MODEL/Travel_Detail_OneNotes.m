//
//  Travel_Detail_OneNotes.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Travel_Detail_OneNotes.h"
#import "Travel_Detail_TwoNotes.h"
@implementation Travel_Detail_OneNotes
- (void)dealloc
{
    [_entry_name release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"notes"]) {
        for (NSDictionary *dic in (NSArray *)value) {
            Travel_Detail_TwoNotes *oneNote = [[Travel_Detail_TwoNotes alloc]initWithDictionary:dic];
            if ([oneNote.col isEqual:@(0)]) {
                if (self.entry_name.length) {
                    oneNote.zeroText = self.entry_name;
                } else {
                    oneNote.col = @(20);
                }
            }
            [self.notess addObject:oneNote];
            [oneNote release];
        }
    }
}
- (NSMutableArray *)notess{
    if (_notess == nil) {
        _notess = [NSMutableArray array];
    }
    return _notess;
}
@end
