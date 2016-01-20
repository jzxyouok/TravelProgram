//
//  AreaSiteModel.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface AreaSiteModel : BSWithIDNSObject
/**
 *  描述label中的内容
 */
@property (nonatomic,copy)NSString *Description;
/**
 *  图片地址
 */
@property (nonatomic,copy)NSString *image_url;
/**
 *  标题内容
 */
@property (nonatomic,copy)NSString *name;
/**
 *  用户评分
 */
@property (nonatomic,copy)NSString *user_score;
@end
