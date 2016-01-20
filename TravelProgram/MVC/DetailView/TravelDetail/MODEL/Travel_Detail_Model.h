//
//  Travel_Detail_Model.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface Travel_Detail_Model : BSWithIDNSObject
/**
 *  Day X;
 */
@property (nonatomic,copy)NSString *day;
/**
 *  DATE
 */
@property (nonatomic,copy)NSString *trip_date;
/**
 *  节点数组,里面存放的是不同天数的内容
 */
@property (nonatomic,retain)NSMutableArray *nodess;
@end
