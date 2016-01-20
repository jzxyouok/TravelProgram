//
//  PlanEnterOne.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface PlanEnterOne : BSWithIDNSObject
/**
 *  今日备忘
 */
@property (nonatomic,copy)NSString *memo;
/**
 *  section (按天数分区)
 */
@property (nonatomic,retain)NSMutableArray *oneArray;
@end
