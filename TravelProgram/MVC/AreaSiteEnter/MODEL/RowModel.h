//
//  RowModel.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface RowModel : BSWithIDNSObject
/**
 *  row中的描述
 */
@property (nonatomic,copy)NSString *descriptionFHY;
/**
 *  右下角的时间字符串
 */
@property (nonatomic,copy)NSString *timeString;
/**
 *  左下角的作者字符串
 */
@property (nonatomic,copy)NSString *userName;
/**
 *  照片数组
 */
@property (nonatomic,retain)NSMutableArray *picArray;
@end
