//
//  Area_ContentModel.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSNSObject.h"

@interface Area_ContentModel : BSNSObject
/**
 *  分类标识 作用未知 备用
 */
@property (nonatomic,copy)NSString *category;
/**
 *  地区地点数组(按照亚洲,欧洲,美洲,大洋洲,非洲,南极洲分组)
 */
@property (nonatomic,retain)NSMutableArray *desinationsArr;
@end
