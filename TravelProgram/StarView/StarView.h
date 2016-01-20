//
//  StarView.h
//  StarView
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  此view占用tag值12345 - 12355
 */
@interface StarView : UIView
- (void)createStarWithNumber:(NSInteger)starNumber andLightedNumber:(NSInteger)lightedNumber;
@end
