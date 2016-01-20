//
//  TripTagsModel.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface TripTagsModel : BSWithIDNSObject
/**
 *  分区头视图中名字 也就是地点名
 */
@property (nonatomic,copy)NSString *name;

@property (nonatomic,retain)NSMutableArray *rowsArray;

@end
