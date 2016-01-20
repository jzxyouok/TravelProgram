//
//  PhotoPageModel.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"

@interface PhotoPageModel : BSWithIDNSObject
@property (nonatomic,copy)NSString *image_url;
@property (nonatomic,copy)NSNumber *image_width;
@property (nonatomic,copy)NSNumber *image_height;
@end
