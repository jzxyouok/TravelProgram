//
//  Topic_Content.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface Topic_Content : BSWithIDNSObject
/**
 *  标题
 */
@property (nonatomic,copy)NSString *name;
/**
 *  小标题
 */
@property (nonatomic,copy)NSString *title;
/**
 *  图片地址
 */
@property (nonatomic,copy)NSString *image_url;
/**
 *  目的地id备用
 */
@property (nonatomic,copy)NSString *distination_id;
@end
