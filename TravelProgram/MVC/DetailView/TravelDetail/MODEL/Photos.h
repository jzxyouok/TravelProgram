//
//  Photos.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface Photos : BSWithIDNSObject
/**
 *  图片高
 */
@property (nonatomic,copy)NSNumber *image_height;
/**
 *  图片宽
 */
@property (nonatomic,copy)NSNumber *image_width;
/**
 *  图片地址
 */
@property (nonatomic,copy)NSString *url;
@end
