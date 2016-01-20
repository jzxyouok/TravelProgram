//
//  CustomerNetworking.h
//  AFNetworking
//
//  Created by 付寒宇 on 15/9/21.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^NetworkingBlock)(id responseObject);
typedef void(^NetworkingErrorBlock)(NSError *error);
@interface CustomerNetworking : NSObject
+ (void)connectWithURLString:(NSString *)urlString andParameters:(NSDictionary *)parameters andBlock:(NetworkingBlock)netWorkingBlock andErrorBlock:(NetworkingErrorBlock)netWorkingErrorBlock;
@end
