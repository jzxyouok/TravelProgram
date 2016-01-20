//
//  Home_TravelContent.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Home_TravelContent.h"
#import "User_Model.h"
@implementation Home_TravelContent
- (void)dealloc
{
    [_name release];
    [_front_cover_photo_url release];
    [_start_date release];
    [_days release];
    [_photos_count release];
    [_userModel release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"user"]) {
        NSDictionary *dictionary = value;
        User_Model *user = [[User_Model alloc]initWithDictionary:dictionary];
        self.userModel = user;
    }
}
@end
