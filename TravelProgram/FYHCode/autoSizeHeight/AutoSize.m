//
//  AutoSize.m
//  AutoSizeHeightOrWidth
//
//  Created by 付寒宇 on 15/10/7.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AutoSize.h"

@implementation AutoSize
+ (CGFloat)AutoSizeOfHeightWithText:(NSString *)text andFont:(UIFont *)font andLabelWidth:(CGFloat)width{
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary *attributesDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil];
    return frame.size.height;
}
+ (CGFloat)AutoSizeOfWidthWithText:(NSString *)text andFont:(UIFont *)font andLabelHeight:(CGFloat)height{
    CGSize size = CGSizeMake(MAXFLOAT, height);
    NSDictionary *attributesDic = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil];
    return frame.size.width;
}
@end
