//
//  AreaSiteEnterModel.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaSiteEnterModel.h"
#import "AreaEnterModel.h"
@implementation AreaSiteEnterModel
- (void)dealloc
{
    [_descriptionFHY release];
    [_lat release];
    [_lng release];
    [_photos_count release];
    [_attraction_trips_count release];
    [_image_url release];
    [_name_en release];
    [_name_zh_cn release];
    [_useEnterModel release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"description"]) {
        self.descriptionFHY = value;
    }
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.useEnterModel = [[AreaEnterModel alloc]init];
        [self.useEnterModel setImage_url:self.image_url];
        self.useEnterModel.name_zh_cn = self.name_zh_cn;
        self.useEnterModel.name_en = self.name_en;
    }
    return self;
}
@end
