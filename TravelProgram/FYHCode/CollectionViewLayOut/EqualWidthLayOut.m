//
//  EqualWidthLayOut.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/16.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "EqualWidthLayOut.h"
@interface EqualWidthLayOut ()
/**
 *  字典存储布局方式
 */
@property (nonatomic, retain) NSMutableArray *allItemAttributeArray;
/**
 *  存每列的最新高度(每次加入itme时会在该字典中寻找最短列, 根据最短列的高度, 生成新视图, 然后更新字典中的数据)
 */
@property (nonatomic, retain) NSMutableDictionary *everyColumsHeightDic;

@end
@implementation EqualWidthLayOut
- (instancetype)init {
    self = [super init];
    if (self) {
        _numberOfColums = 2;
        _itemSpacing = 10;
        self.allItemAttributeArray = [NSMutableArray array];
        self.everyColumsHeightDic = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark  三个关键方法之一: 在此方法中, 将生成每个itme的布局信息, 就是为每个item生成一个UICollectionViewLayoutAttributes类对象, 并给该对象的frame附上item的frame的信息, 然后加入到m_allItemAttributeArray中去
- (void)prepareLayout {
    //先调用父类的方法
    [super prepareLayout];
    
    //根据有多少列和视图的间隔, 计算出每列的宽度
    CGFloat itemWidth = (self.collectionView.bounds.size.width - (self.itemSpacing * (self.numberOfColums + 1))) / self.numberOfColums;
    [self.allItemAttributeArray removeAllObjects];
    //初始化每列的原始高度
    for (int i = 0; i < self.numberOfColums; i++) {
        [self.everyColumsHeightDic setObject:@(0.0f) forKey:[@(i) description]];
    }
    //设置布局
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //得到布局中最小的高度的cell的index
        NSInteger minHeightColum = [self getMinHeightColum];
        //计算出item的x
        CGFloat x = self.itemSpacing + (self.itemSpacing + itemWidth) * minHeightColum;
        //计算item的y
        CGFloat y = [self.everyColumsHeightDic[[@(minHeightColum) description]] floatValue];
        //使用代理计算item高度
        CGFloat itemHeight = [(id<EqualWidthLayOutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath];
        //生成布局信息
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attribute.frame = CGRectMake(x, y, itemWidth, itemHeight);
        //加入布局数组
        [self.allItemAttributeArray addObject:attribute];
        y += self.itemSpacing;
        y += itemHeight;
        //更新字典中的高度信息
        [self.everyColumsHeightDic setObject:@(y) forKey:[@(minHeightColum) description]];
    }
}
#pragma mark 实现瀑布流的关键方法二: 在此方法中, 当滑动collectionView时, UICollectionView会向布局方式实时询问将要展示在屏幕上的item的布局信息, 因此, 在此方法里只需要返回上一方法中返回的布局信息即可
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.allItemAttributeArray.count];
    [self.allItemAttributeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;
        //将指定区域内的布局信息放入数组
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [array addObject:attributes];
        }
    }];
    return array;
}

#pragma mark  实现瀑布流的关键方法三: 该方法返回使用该布局方式的UICollectionView的对象的size
- (CGSize)collectionViewContentSize {
    NSString *str = [@([self getMaxHeightColum]) description];
    return CGSizeMake(self.collectionView.bounds.size.width, [self.everyColumsHeightDic[str] floatValue]);
    //当某个UICollectionView使用该布局方式时([[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout]),self.collectionView属性会自动指向它，
    //    //这也是可以通过询问collectionView的代理对象获得自己所需要的视图高度信息的原因
    //    [(id<CustomViewLayoutDelegate>)self.collectionView.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath]
}

#pragma mark 得到高度最小的列的方法
- (NSInteger)getMinHeightColum{
    NSInteger count = [self.everyColumsHeightDic count];
    NSInteger minIndex = 0;
    CGFloat minHeight = [self.everyColumsHeightDic[@"0"] floatValue];
    for (int i = 1; i < count; i ++) {
        if ([self.everyColumsHeightDic[[@(i) description]] floatValue] < minHeight) {
            minHeight = [self.everyColumsHeightDic[[@(i) description]] floatValue];
            minIndex = i;
        }
    }
    return minIndex;
}
#pragma mark 获得最长列方法, 同最短列方法相同
- (NSInteger)getMaxHeightColum{
    NSInteger count = (int)[self.everyColumsHeightDic count];
    NSInteger maxIndex = 0;
    CGFloat maxHeight = [self.everyColumsHeightDic[@"0"] floatValue];
    for (int i = 1; i < count; i ++) {
        if ([self.everyColumsHeightDic[[@(i) description]] floatValue] > maxHeight) {
            maxHeight = [self.everyColumsHeightDic[[@(i) description]] floatValue];
            maxIndex = i;
        }
    }
    return maxIndex;
}

@end
