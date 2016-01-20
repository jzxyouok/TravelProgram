//
//  EnterView.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/15.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  AreaEnterModel;
@protocol EnterViewDelegate <NSObject>

- (void)pushToPage:(NSInteger)buttonTag andModel:(AreaEnterModel *)content;

@end


@interface EnterView : UIVisualEffectView
@property (nonatomic,retain)AreaEnterModel *viewContent;
@property (nonatomic,assign)id<EnterViewDelegate> delegate;
- (void)starShow;
@end
