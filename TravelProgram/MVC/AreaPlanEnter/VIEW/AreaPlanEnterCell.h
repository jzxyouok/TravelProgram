//
//  AreaPlanEnterCell.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
@class PlanEnterTwo;
@interface AreaPlanEnterCell : BSTableViewCell
@property (nonatomic,retain)PlanEnterTwo *cellContent;
+ (AreaPlanEnterCell *)areaPlanEnterCellWithTableView:(UITableView *)tableView;
@end
