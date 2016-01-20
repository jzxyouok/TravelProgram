//
//  LeftView.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/20.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftViewDelegate <NSObject>

- (void)scrollTo:(NSIndexPath *)indexPath;

@end
@interface LeftView : UIView
@property (nonatomic,retain)NSArray *nsIndexPathArray;
@property (nonatomic,retain)NSArray *titileArray;
@property (nonatomic,retain)UITableView *leftTableView;
@property (nonatomic,retain)UIButton *bigButton;
@property (nonatomic,assign)id<LeftViewDelegate> delegate;
@end
