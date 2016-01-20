//
//  PlanEnterTwo.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface PlanEnterTwo : BSWithIDNSObject
/**
 *  第x站
 */
@property (nonatomic,retain)NSNumber *position;
/**
 *  第X站: (名字)
 */
@property (nonatomic,copy)NSString *entry_name;
/**
 *  图片地址
 */
@property (nonatomic,copy)NSString *image_url;
/**
 *  维度
 */
@property (nonatomic,copy)NSString *lat;
/**
 *  经度
 */
@property (nonatomic,copy)NSString *lng;
/**
 *  描述label的内容
 */
@property (nonatomic,copy)NSString *tips;
/**
 *  备用留作旅行地id跳转
 */
@property (nonatomic,copy)NSString *entry_id;

@end
