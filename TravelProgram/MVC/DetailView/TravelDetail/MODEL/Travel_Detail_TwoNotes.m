//
//  Travel_Detail_TwoNotes.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Travel_Detail_TwoNotes.h"
#import "Photos.h"
@implementation Travel_Detail_TwoNotes
- (void)dealloc
{
    [_col release];
    [_descriptionF release];
    [_photos release];
    [_zeroText release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"photo"]) {
        self.photos = [[Photos alloc]initWithDictionary:value];
    }else if ([key isEqualToString:@"description"]){
        self.descriptionF = value;
    }
}
@end
