//
//  AreaSiteEnterUpView.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AreaSiteEnterModel;
@interface AreaSiteEnterUpView : UIView
/**
 *  三个button的自定义view传入model
 */
@property (nonatomic,retain)AreaSiteEnterModel *upViewContent;
@property (nonatomic,retain)UIButton *goTravel;
@property (nonatomic,retain)UIButton *goMap;
@property (nonatomic,retain)UIButton *goPhoto;
@end
