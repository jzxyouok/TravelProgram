//
//  Area_CollectionCell.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/9.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSCollectionViewCell.h"
@class Area_DestinationsModel;
@interface Area_CollectionCell : BSCollectionViewCell
@property (nonatomic,retain)Area_DestinationsModel *content;
@end
