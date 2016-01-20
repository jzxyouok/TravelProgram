//
//  EqualWidthLayOut.h
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EqualWidthLayOut;
@protocol EqualWidthLayOutDelegate <NSObject>

//协议方法 根据indexPath返回每个cell的高度
- (CGFloat)collectionView:(UICollectionView *)view layout:(EqualWidthLayOut *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface EqualWidthLayOut : UICollectionViewLayout
@property (nonatomic, assign) id<EqualWidthLayOutDelegate> delegate;
/**
 *  可设置单元格列数
 */
@property (nonatomic,assign)NSInteger numberOfColums;
/**
 *  cell的间距
 */
@property (nonatomic,assign)CGFloat itemSpacing;
@end
