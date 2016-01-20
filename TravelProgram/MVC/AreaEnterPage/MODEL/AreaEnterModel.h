//
//  AreaEnterModel.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/14.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface AreaEnterModel : BSWithIDNSObject
/**
 *  地点中英文名
 */
@property (nonatomic,copy)NSString *name_zh_cn;
@property (nonatomic,copy)NSString *name_en;
/**
 *  图片地址
 */
@property (nonatomic,copy)NSString *image_url;
@end
