//
//  User_Model.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface User_Model : BSWithIDNSObject
/**
 *  用户头像地址
 */
@property (nonatomic,copy)NSString *image;
/**
 *  用户名字
 */
@property (nonatomic,copy)NSString *name;
@end
