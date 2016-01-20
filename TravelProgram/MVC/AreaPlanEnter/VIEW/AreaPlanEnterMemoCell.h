//
//  AreaPlanEnterMemoCell.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
@class PlanEnterOne;
@interface AreaPlanEnterMemoCell : BSTableViewCell
@property (nonatomic,retain)PlanEnterOne *memoCellContent;
+ (AreaPlanEnterMemoCell *)areaPlanEnterMemoCellWithTableView:(UITableView *)tableView;
@end
