//
//  Travel_Detail_TwoNotes.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"
@class Photos;
@interface Travel_Detail_TwoNotes : BSWithIDNSObject
/**
 *  notes中的位数(NSNumber)
 */
@property (nonatomic,retain)NSNumber *col;
/**
 *  描述,为label中显示的内容
 */
@property (nonatomic,copy)NSString *descriptionF;
/**
 *  如果有图片的话储存图片
 */
@property (nonatomic,retain)Photos *photos;
/**
 *  如果在数组中下标为零的话给出zeroLabel的内容
 */
@property (nonatomic,copy)NSString *zeroText;
@end
