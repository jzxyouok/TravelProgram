//
//  Area_DestinationsModel.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface Area_DestinationsModel : BSWithIDNSObject
/**
 *  地区中文名
 */
@property (nonatomic,copy)NSString *name_zh_cn;
/**
 *  地区英文名
 */
@property (nonatomic,copy)NSString *name_en;
/**
 *  图片地址
 */
@property (nonatomic,copy)NSString *image_url;
/**
 *  旅行目的地数目
 */
@property (nonatomic,copy)NSString *poi_countF;
@end
