//
//  Topic_Cell.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
@class Topic_Content;
@interface Topic_Cell : BSTableViewCell
/**
 *  MODEL
 */
@property (nonatomic,retain)Topic_Content *content;
+ (Topic_Cell *)topic_CellWithTableView:(UITableView *)tableView;
@end
