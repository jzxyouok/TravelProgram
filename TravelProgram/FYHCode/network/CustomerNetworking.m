//
//  CustomerNetworking.m
//  AFNetworking
//
//  Created by 付寒宇 on 15/9/21.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "CustomerNetworking.h"
#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"
@interface CustomerNetworking ()
@property (nonatomic,copy)NetworkingBlock netWorkingBlock;
@end
@implementation CustomerNetworking


+ (void)connectWithURLString:(NSString *)urlString andParameters:(NSDictionary *)parameters andBlock:(NetworkingBlock)netWorkingBlock andErrorBlock:(NetworkingErrorBlock)netWorkingErrorBlock{
    CustomerNetworking *customer = [[CustomerNetworking alloc]init];
    [customer connectWithURLString:urlString andParameters:parameters andBlock:netWorkingBlock andErrorBlock:netWorkingErrorBlock];
}

- (void)connectWithURLString:(NSString *)urlString andParameters:(NSDictionary *)parameters andBlock:(NetworkingBlock)netWorkingBlock andErrorBlock:(NetworkingErrorBlock)netWorkingErrorBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    manager.securityPolicy.allowInvalidCertificates = YES;
    if (parameters) {
        [manager POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            netWorkingBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            netWorkingErrorBlock(error);
            NSLog(@"%@",error);
        }];
    }else{
        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            netWorkingBlock(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            netWorkingErrorBlock(error);
            NSLog(@"%@",error);
        }];
    }
}


@end
