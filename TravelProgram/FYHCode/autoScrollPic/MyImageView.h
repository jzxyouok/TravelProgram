//
//  MyImageView.h
//  轮播图
//
//  Created by 付寒宇 on 15/9/21.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Home_TravelContent;
@protocol MyImageViewDelegate <NSObject>

- (void)touchBegin;
- (void)touchLeft;

@end


@interface MyImageView : UIView
@property (nonatomic,retain)Home_TravelContent *content;
@property (nonatomic,retain)UIImageView *backGroundPic;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic,retain)UILabel *subTitle;
@property (nonatomic,retain)UIView *placeView;
@property (nonatomic,retain)UIImageView *shadowPic;
@property (nonatomic,assign)id<MyImageViewDelegate> delegate;
@end
