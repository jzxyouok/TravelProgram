//
//  SearchResultView.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol searchResultViewDelegate <NSObject>

- (void)pushToViewController:(UIViewController *)viewController;

@end
@interface SearchResultView : UIView
@property (nonatomic,copy)NSString *searchWord;
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,assign)id<searchResultViewDelegate> delegate;
@end
