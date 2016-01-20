//
//  GoMapViewController.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSViewController.h"

@interface GoMapViewController : BSViewController
@property (nonatomic,copy)NSString *name;
/**
 *  经度
 */
@property (nonatomic,assign)double lat;
/**
 *  纬度
 */
@property (nonatomic,assign)double lng;
@end
