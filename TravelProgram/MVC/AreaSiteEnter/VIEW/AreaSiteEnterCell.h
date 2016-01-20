//
//  AreaSiteEnterCell.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"

@protocol AreaSiteEnterCellDelegate <NSObject>

- (void)pushToPhotoViewController:(UIViewController *)photoEnterViewController;

@end

@class RowModel;
@interface AreaSiteEnterCell : BSTableViewCell
@property (nonatomic,retain)RowModel *rowContent;
+ (AreaSiteEnterCell *)areaSiteEnterCellWithTableView:(UITableView *)tableView;
@property (nonatomic,assign)id<AreaSiteEnterCellDelegate> delegate;
@end
