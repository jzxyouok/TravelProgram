//
//  Travel_Detail_OneNotes.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface Travel_Detail_OneNotes : BSWithIDNSObject
/**
 *  第一个cell上显示的名字
 */
@property (nonatomic,copy)NSString *entry_name;
/**
 *  第二个note数组
 */
@property (nonatomic,copy)NSMutableArray *notess;
@end
