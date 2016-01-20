//
//  AutoSize.h
//  AutoSizeHeightOrWidth
//
//  Created by 付寒宇 on 15/10/7.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AutoSize : NSObject
+ (CGFloat)AutoSizeOfHeightWithText:(NSString *)text andFont:(UIFont *)font andLabelWidth:(CGFloat)width;
+ (CGFloat)AutoSizeOfWidthWithText:(NSString *)text andFont:(UIFont *)font andLabelHeight:(CGFloat)height;
@end
