//
//  ShowPicView.h
//  轮播图
//
//  Created by 付寒宇 on 15/9/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickPic)(NSInteger number);
@interface ShowPicView : UIView
@property (nonatomic,copy)clickPic clickBlock;
- (instancetype)initWithFrame:(CGRect)frame andPicUrlStringArray:(NSArray *)picArray andTimeInterval:(CGFloat)timeInterval;
- (void)clickBlock:(clickPic)clickBlock;

@end
