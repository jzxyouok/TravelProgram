//
//  PhotoModel.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSWithIDNSObject.h"
#import <UIKit/UIKit.h>
@interface PhotoModel : BSWithIDNSObject
/**
 *  照片地址
 */
@property (nonatomic,copy)NSString *photo_url;
/**
 *  照片的宽高
 */
@property (nonatomic,retain)NSNumber *height;
@property (nonatomic,retain)NSNumber *width;
/**
 *  宽高比
 */
@property (nonatomic,assign)CGFloat proportion;
@end
