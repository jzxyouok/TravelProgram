//
//  Topic_Detail_CellThree.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/13.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
/**
 *  有文字描述有图片
 */
@class Topic_Detail_Model;
@interface Topic_Detail_CellThree : BSTableViewCell
@property (nonatomic,retain)Topic_Detail_Model *cellContent;
+ (Topic_Detail_CellThree *)topic_Detail_CellThreeWithTableView:(UITableView *)tableView;
@end
