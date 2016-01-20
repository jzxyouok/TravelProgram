//
//  Home_TravelCell.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
@class Home_TravelContent;
@interface Home_TravelCell : BSTableViewCell
@property (nonatomic,retain)Home_TravelContent *content;
+ (Home_TravelCell *)Home_TravelCellWithTableView:(UITableView *)tableView;
@end
