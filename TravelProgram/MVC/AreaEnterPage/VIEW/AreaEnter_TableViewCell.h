//
//  AreaEnter_TableViewCell.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/14.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
@class AreaEnterModel;
@interface AreaEnter_TableViewCell : BSTableViewCell
/**
 *  MODEL
 */
@property (nonatomic,retain)AreaEnterModel *content;
@property (nonatomic,retain)UIImageView *backGroundPic;
+ (AreaEnter_TableViewCell *)areaEnter_TableViewCellWithTableView:(UITableView *)tableView;
@end
