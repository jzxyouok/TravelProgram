//
//  Topic_Detail_CellTwo.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/13.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
//显示title和文字的cell
@class Topic_Detail_Model;
@interface Topic_Detail_CellTwo : BSTableViewCell
@property (nonatomic,retain)Topic_Detail_Model *cellContent;
+ (Topic_Detail_CellTwo *)topic_Detail_CellTwoWithTableView:(UITableView *)tableView;
@end
