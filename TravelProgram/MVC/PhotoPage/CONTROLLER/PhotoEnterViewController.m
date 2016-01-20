//
//  PhotoEnterViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "PhotoEnterViewController.h"
#import "PhotoPageModel.h"
#import "PhotoEnterCell.h"
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
@interface PhotoEnterViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,PhotoEnterCellDelegate>
@property (nonatomic,retain)UICollectionView *collectionView;
@end

@implementation PhotoEnterViewController
- (void)dealloc
{
    [_contentArray release];
    [_collectionView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [flowLayout setMinimumLineSpacing:0];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    [flowLayout setItemSize:self.collectionView.frame.size];
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setScrollsToTop:NO];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    [self.collectionView registerClass:[PhotoEnterCell class] forCellWithReuseIdentifier:@"photoEnterCell"];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.collectionView];
    [self.collectionView setContentOffset:CGPointMake(_photoNumber * kWidth, 0)];
    [_collectionView release];
}

#pragma mark 返回分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark返回单元格数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _contentArray.count ? _contentArray.count : 0;
}
#pragma mark 返回单元格

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoPageModel *photoModel = _contentArray[indexPath.row];
    PhotoEnterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoEnterCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.cellContent = photoModel;
    return cell;
}

- (void)popBack{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
