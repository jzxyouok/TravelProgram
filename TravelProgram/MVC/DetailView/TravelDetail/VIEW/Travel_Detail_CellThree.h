//
//  Travel_Detail_CellThree.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
@class Travel_Detail_TwoNotes;
@interface Travel_Detail_CellThree : BSTableViewCell
@property (nonatomic,retain)Travel_Detail_TwoNotes *cellContent;
+ (Travel_Detail_CellThree *)travel_Detail_CellThreeWithTableView:(UITableView *)tableView;
@end