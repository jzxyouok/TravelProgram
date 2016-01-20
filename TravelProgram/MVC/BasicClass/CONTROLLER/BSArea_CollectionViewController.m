//
//  BSArea_CollectionViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "BSArea_CollectionViewController.h"
#import "Area_CollectionCell.h"
#import "Area_Collection_Header.h"
#import "Area_Collection_Footer.h"
@interface BSArea_CollectionViewController ()
@end

@implementation BSArea_CollectionViewController
- (void)dealloc
{
    [_collectionView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setMinimumInteritemSpacing:15];
    [flowLayout setMinimumLineSpacing:10];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 15, 10, 15)];
    [flowLayout setHeaderReferenceSize:CGSizeMake(kWidth, 30)];
    [flowLayout setItemSize:CGSizeMake((kWidth - 15 * 3) / 2, kHeight / 3)];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight - 64 - 49) collectionViewLayout:flowLayout];
    [self.collectionView setBackgroundColor:[UIColor blackColor]];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    [self.collectionView setBounces:NO];
    //注册单元格和头尾视图
    [self.collectionView registerClass:[Area_CollectionCell class] forCellWithReuseIdentifier:@"Area_CollectionCell"];
    [self.collectionView registerClass:[Area_Collection_Header class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Area_Collection_Header"];
    [self.collectionView registerClass:[Area_Collection_Footer class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Area_Collection_Footer"];
    [self.view addSubview:self.collectionView];
    [_collectionView release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
