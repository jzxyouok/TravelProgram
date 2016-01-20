//
//  AreaPlansCell.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/15.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
@class AreaPlanModel;
@interface AreaPlansCell : BSTableViewCell
@property (nonatomic,retain)AreaPlanModel *content;
+ (AreaPlansCell *)areaPlansCellWithTableView:(UITableView *)tableView;
@end
