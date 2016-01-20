//
//  PhotoEnterCell.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
@protocol PhotoEnterCellDelegate <NSObject>
- (void)popBack;

@end
#import "BSCollectionViewCell.h"

@class PhotoPageModel;
@interface PhotoEnterCell : BSCollectionViewCell
@property (nonatomic,retain)PhotoPageModel *cellContent;
@property (nonatomic,assign)id<PhotoEnterCellDelegate> delegate;
@end
