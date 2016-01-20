//
//  SearchButtonsView.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol SearchButtonsViewDelegate <NSObject>

- (void)pushToViewController:(UIViewController *)viewController;
- (void)scrolling;

@end
@interface SearchButtonsView : UIView

@property (nonatomic,retain)NSArray *contentArray;
@property (nonatomic,retain)UICollectionView *states;
@property (nonatomic,assign)id<SearchButtonsViewDelegate> delegate;
@end