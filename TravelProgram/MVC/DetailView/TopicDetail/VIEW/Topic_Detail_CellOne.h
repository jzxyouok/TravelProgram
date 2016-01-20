//
//  Topic_Detail_CellOne.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/13.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
//仅有文字描述的
@class Topic_Detail_Model;
@interface Topic_Detail_CellOne : BSTableViewCell
@property (nonatomic,retain)Topic_Detail_Model *cellContent;
+ (Topic_Detail_CellOne *)topic_Detail_CellOneWithTableView:(UITableView *)tableView;
@end
