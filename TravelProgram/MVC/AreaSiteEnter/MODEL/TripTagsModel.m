//
//  TripTagsModel.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "TripTagsModel.h"
#import "RowModel.h"
@implementation TripTagsModel
- (void)dealloc
{
    [_name release];
    [_rowsArray release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"attraction_contents"]) {
        NSArray *array = value;
        for (NSDictionary *dic in array) {
            RowModel *rowModel = [[RowModel alloc]initWithDictionary:dic];
            [self.rowsArray addObject:rowModel];
            [rowModel release];
        }
    }
}

- (NSMutableArray *)rowsArray{
    if (_rowsArray == nil) {
        _rowsArray = [[NSMutableArray alloc]init];
    }
    return _rowsArray;
}
@end
