//
//  SearchButtonsView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "SearchButtonsView.h"
#import "SearchButtonCell.h"
#import "Area_DestinationsModel.h"
#import "IDTravelViewController.h"
@interface SearchButtonsView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end
@implementation SearchButtonsView
- (void)dealloc
{
    [_states release];
    [_contentArray release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake((frame.size.width - 20 ) / 3, 30)];
        [flowLayout setSectionInset:UIEdgeInsetsMake(5, 5, 5, 5)];
        [flowLayout setMinimumLineSpacing:5];
        [flowLayout setMinimumInteritemSpacing:5];
        self.states = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:flowLayout];
        [self.states setBackgroundColor:[UIColor colorWithRed:0.902 green:0.9255 blue:0.9529 alpha:1.0]];
        [self.states setShowsVerticalScrollIndicator:NO];
        [self.states registerClass:[SearchButtonCell class] forCellWithReuseIdentifier:@"searchButtonCell"];
        [self.states setDelegate:self];
        [self.states setDataSource:self];
        [self addSubview:self.states];
        [_states release];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _contentArray.count ? _contentArray.count : 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SearchButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"searchButtonCell" forIndexPath:indexPath];
    if (_contentArray.count) {
        Area_DestinationsModel *model = _contentArray[indexPath.row];
        cell.cellLabelText = model.name_zh_cn;
    }
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_delegate scrolling];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Area_DestinationsModel *model = _contentArray[indexPath.row];
    IDTravelViewController *travel = [[IDTravelViewController alloc]init];
    [travel setSearchWord:model.name_zh_cn];
    [_delegate pushToViewController:travel];
    [travel release];
}
- (void)setContentArray:(NSArray *)contentArray{
    if (_contentArray != contentArray) {
        [_contentArray release];
        _contentArray = [contentArray retain];
        [self.states reloadData];
    }
}
@end
