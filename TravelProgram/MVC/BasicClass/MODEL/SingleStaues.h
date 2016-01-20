//
//  SingleStaues.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/14.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleStaues : NSObject
@property (nonatomic,assign)NSInteger statues;
+ (SingleStaues *)shareNetStatus;
@end
