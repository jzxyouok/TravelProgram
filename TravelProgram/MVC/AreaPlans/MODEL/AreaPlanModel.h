//
//  AreaPlanModel.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/15.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface AreaPlanModel : BSWithIDNSObject
/**
 *  描述
 */
@property (nonatomic,copy)NSString *Description;
/**
 *  行程图片
 */
@property (nonatomic,copy)NSString *image_url;
/**
 *  行程标题
 */
@property (nonatomic,copy)NSString *name;
/**
 *  行程天数
 */
@property (nonatomic,copy)NSString *plan_days_count;
/**
 *  行程旅行地数目
 */
@property (nonatomic,copy)NSString *plan_nodes_count;
@end
