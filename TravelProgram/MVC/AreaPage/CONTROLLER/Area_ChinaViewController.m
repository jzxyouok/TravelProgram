//
//  Area_ChinaViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "Area_ChinaViewController.h"
#import "Area_CollectionCell.h"
#import "Area_Collection_Header.h"
#import "Area_Collection_Footer.h"
#import "Area_ContentModel.h"
#import "AreaEnterViewController.h"
@interface Area_ChinaViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation Area_ChinaViewController
- (void)dealloc
{
    [_contentArray release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView setScrollsToTop:NO];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.contentArray.count ? self.contentArray.count : 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    Area_ContentModel *temp = self.contentArray[section];
    if (section == 0) {
        return temp.desinationsArr.count ? temp.desinationsArr.count : 3;
    }else{
        return temp.desinationsArr.count ? temp.desinationsArr.count : 23;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Area_CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Area_CollectionCell" forIndexPath:indexPath];
    if (self.contentArray.count) {
        Area_ContentModel *temp = self.contentArray[indexPath.section];
        cell.content = [temp.desinationsArr objectAtIndex:indexPath.row];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        Area_Collection_Footer *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Area_Collection_Footer" forIndexPath:indexPath];
        return footer;
    }
        Area_Collection_Header *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Area_Collection_Header" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [header setHeaderContent:@"港澳台"];
    }else{
        [header setHeaderContent:@"大陆"];
    }
        return header;
}
//点击进入地区二级页面
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.contentArray.count) {
        Area_ContentModel *temp = self.contentArray[indexPath.section];
        Area_DestinationsModel *chickModel = [temp.desinationsArr objectAtIndex:indexPath.row];
        AreaEnterViewController *areaEnterViewController = [[AreaEnterViewController alloc]init];
        areaEnterViewController.content = chickModel;
        [self.parentViewController.navigationController pushViewController:areaEnterViewController animated:YES];
        [areaEnterViewController release];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section != 1) {
        return CGSizeZero;
    } else {
        return CGSizeMake(kWidth, 45);
    }
}
- (void)setContentArray:(NSMutableArray *)contentArray{
    if (_contentArray != contentArray) {
        _contentArray = [contentArray retain];
    }
}
@end
