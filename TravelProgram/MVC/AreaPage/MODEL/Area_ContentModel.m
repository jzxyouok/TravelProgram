//
//  Area_ContentModel.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Area_ContentModel.h"
#import "Area_DestinationsModel.h"
@implementation Area_ContentModel
- (void)dealloc
{
    [_category release];
    [_desinationsArr release];
    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"destinations"]) {
        NSArray *array = value;
        for (NSDictionary *dictionary in array) {
            Area_DestinationsModel *oneContent = [[Area_DestinationsModel alloc]initWithDictionary:dictionary];
            [self.desinationsArr addObject:oneContent];
            [oneContent release];
        }
    }
}
- (NSMutableArray *)desinationsArr{
    if (_desinationsArr == nil) {
        _desinationsArr = [[NSMutableArray alloc]init];
    }
    return _desinationsArr;
}
@end
