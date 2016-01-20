//
//  BSWithIDNSObject.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSWithIDNSObject : NSObject
/**
 *  id标识号
 */
@property (nonatomic,copy)NSString *ID;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
