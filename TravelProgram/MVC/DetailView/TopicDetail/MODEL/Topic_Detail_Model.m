//
//  Topic_Detail_Model.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/12.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "Topic_Detail_Model.h"
#import "Topic_Detail_Attraction.h"
#import "Topic_Detail_notes.h"
@implementation Topic_Detail_Model
- (void)dealloc
{
    [_DescriptionMutable release];
    [_image_url release];
    [_image_height release];
    [_image_width release];
    [_topic_detail_attracion release];
    [_topic_detail_notes release];
    [_description_user_ids release];
    [_title release];
    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"description"]) {
        self.DescriptionMutable = [NSString stringWithString:value];
    }
    if ([key isEqualToString:@"attraction"]) {
        NSDictionary *tempDic = value;
        Topic_Detail_Attraction *attraction = [[Topic_Detail_Attraction alloc]initWithDictionary:tempDic];
        self.topic_detail_attracion = attraction;
    }
    if ([key isEqualToString:@"note"]) {
        NSDictionary *notesDic = value;
        Topic_Detail_notes *notes = [[Topic_Detail_notes alloc]initWithDictionary:notesDic];
        self.topic_detail_notes = notes;
    }
    
}
@end
