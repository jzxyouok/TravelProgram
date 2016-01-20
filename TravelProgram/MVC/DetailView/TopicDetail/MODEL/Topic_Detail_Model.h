//
//  Topic_Detail_Model.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/12.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSNSObject.h"
@class Topic_Detail_Attraction;
@class Topic_Detail_notes;
@interface Topic_Detail_Model : BSNSObject
/**
 *  描述,为label内容
 */
@property (nonatomic,copy)NSString *DescriptionMutable;
/**
 *  图片地址
 */
@property (nonatomic,copy)NSString *image_url;

@property (nonatomic,copy)NSString *image_width;
@property (nonatomic,copy)NSString *image_height;
/**
 *  描述地点定位(button的title)
 */
@property (nonatomic,retain)Topic_Detail_Attraction *topic_detail_attracion;
/**
 *  照片左下角作者描述
 */
@property (nonatomic,retain)Topic_Detail_notes *topic_detail_notes;
/**
 *  描述中 key:id   value:用户中文名 ,替换用
 */
@property (nonatomic,retain)NSDictionary *description_user_ids;
/**
 * 如果有titileLabel那么显示如下
 */
@property (nonatomic,copy)NSString *title;
@end
