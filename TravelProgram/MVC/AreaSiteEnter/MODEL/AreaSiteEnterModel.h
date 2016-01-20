//
//  AreaSiteEnterModel.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"
/**
 *  最外层model
 */
@class AreaEnterModel;
@interface AreaSiteEnterModel : BSWithIDNSObject
/**
 *  上方视图中描述
 */
@property (nonatomic,copy)NSString *descriptionFHY;

/**
 *  纬度
 */
@property (nonatomic,copy)NSString *lat;
/**
 *  经度
 */
@property (nonatomic,copy)NSString *lng;
/**
 *  照片数量
 */
@property (nonatomic,copy)NSString *photos_count;
/**
 *  游记数量
 */
@property (nonatomic,copy)NSString *attraction_trips_count;

/**
 *  以下内容封装为EnterModel
 */
@property (nonatomic,copy)NSString *image_url;
@property (nonatomic,copy)NSString *name_zh_cn;
@property (nonatomic,copy)NSString *name_en;
/**
 *  enterModel
 */
@property (nonatomic,retain)AreaEnterModel *useEnterModel;
@end
