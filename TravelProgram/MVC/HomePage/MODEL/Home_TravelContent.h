//
//  Home_TravelContent.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"
@class User_Model;
@interface Home_TravelContent : BSWithIDNSObject
/**
 *  游记标题
 */
@property (nonatomic,copy)NSString *name;
/**
 *  图片地址
 */
@property (nonatomic,copy)NSString *front_cover_photo_url;
/**
 *  开始日期
 */
@property (nonatomic,copy)NSString *start_date;
/**
 *  游记天数
 */
@property (nonatomic,copy)NSString *days;
/**
 *  照片数目
 */
@property (nonatomic,copy)NSString *photos_count;
/**
 *  用户标识
 */
@property (nonatomic,retain)User_Model *userModel;

@end
