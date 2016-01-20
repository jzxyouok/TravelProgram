//
//  RowModel.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "RowModel.h"
#import "PhotoModel.h"
@implementation RowModel
- (void)dealloc
{
    [_descriptionFHY release];
    [_timeString release];
    [_userName release];
    [_picArray release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"trip"]) {
        NSDictionary *dic = value;
        self.timeString = [[dic objectForKey:@"start_date"] isKindOfClass:[NSNull class]] ? @"" :  [dic objectForKey:@"start_date"];
        self.userName = [[(NSDictionary *)[dic objectForKey:@"user"] objectForKey:@"name"] isKindOfClass:[NSNull class]] ? @"" : [(NSDictionary *)[dic objectForKey:@"user"] objectForKey:@"name"];
    }
    if ([key isEqualToString:@"description"]) {
        self.descriptionFHY = value;
    }
    if ([key isEqualToString:@"notes"]) {
        NSArray *array = value;
        for (NSDictionary *photoDic in array) {
            if ([photoDic objectForKey:@"photo_url"]) {
                PhotoModel *photoModel = [[PhotoModel alloc]initWithDictionary:photoDic];
                photoModel.proportion = [photoModel.width floatValue] / [photoModel.height floatValue];
                [self.picArray addObject:photoModel];
                [photoModel release];
            }
        }
    }
}

- (NSMutableArray *)picArray{
    if (_picArray == nil) {
        _picArray = [[NSMutableArray alloc]init];
    }
    return _picArray;
}
@end
