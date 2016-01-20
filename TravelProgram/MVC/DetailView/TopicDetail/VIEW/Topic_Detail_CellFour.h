//
//  Topic_Detail_CellFour.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/13.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
//显示title和文字的cell 和图片
@class Topic_Detail_Model;
@interface Topic_Detail_CellFour : BSTableViewCell
@property (nonatomic,retain)Topic_Detail_Model *cellContent;
+ (Topic_Detail_CellFour *)topic_Detail_CellFourWithTableView:(UITableView *)tableView;
@end
