//
//  Area_DestinationsModel.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Area_DestinationsModel.h"

@implementation Area_DestinationsModel
- (void)dealloc
{
    [_image_url release];
    [_name_en release];
    [_name_zh_cn release];
    [_poi_countF release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = [value stringValue];
    }else if ([key isEqualToString:@"poi_count"]){
        self.poi_countF = [value stringValue];
    }
}
@end
