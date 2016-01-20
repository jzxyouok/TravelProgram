//
//  AreaSiteEnterCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/17.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "AreaSiteEnterCell.h"
#import "RowModel.h"
#import "AutoSize.h"
#import "PhotoModel.h"
#import "ScrollPicViewCell.h"
#import "PhotoEnterViewController.h"
#import "PhotoEnterViewController.h"
#import "PhotoModel.h"
#import "PhotoPageModel.h"
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
@interface AreaSiteEnterCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,retain)UILabel *descriptionLabel;
@property (nonatomic,retain)UICollectionView *picView;
@property (nonatomic,retain)UILabel *userLabel;
@property (nonatomic,retain)UILabel *timeLabel;
@property (nonatomic,retain)UIView *separatorView;
@property (nonatomic,assign)CGFloat picHeight;
@end
@implementation AreaSiteEnterCell
- (void)dealloc
{
    [_separatorView release];
    [_descriptionLabel release];
    [_picView release];
    [_userLabel release];
    [_timeLabel release];
    [_rowContent release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.autoresizesSubviews = NO;
        [self.contentView setBackgroundColor:[UIColor colorWithRed:0.8824 green:0.9059 blue:0.9333 alpha:1.0]];
        
        self.descriptionLabel = [[UILabel alloc]init];
        [self.descriptionLabel setNumberOfLines:0];
        [self.descriptionLabel setFont:[UIFont systemFontOfSize:15]];
        [self.contentView addSubview:self.descriptionLabel];
        [_descriptionLabel release];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setMinimumInteritemSpacing:10];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        self.picView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self.picView setScrollsToTop:NO];
        [self.picView setDelegate:self];
        [self.picView setDataSource:self];
        [self.picView registerClass:[ScrollPicViewCell class] forCellWithReuseIdentifier:@"scrollPicViewCell"];
        [self.picView setShowsHorizontalScrollIndicator:NO];
        [self.picView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.picView];
        [_picView release];
        
        self.userLabel = [[UILabel alloc]init];
        [self.userLabel setFont:[UIFont systemFontOfSize:15]];
        [self.userLabel setAlpha:0.5];
        [self.contentView addSubview:self.userLabel];
        [_userLabel release];
        
        self.timeLabel = [[UILabel alloc]init];
        [self.timeLabel setTextAlignment:NSTextAlignmentRight];
        [self.timeLabel setFont:[UIFont systemFontOfSize:15]];
        [self.timeLabel setAlpha:0.5];
        [self.contentView addSubview:self.timeLabel];
        [_timeLabel release];
        
        self.separatorView = [[UIView alloc]init];
        [self.separatorView setBackgroundColor:[UIColor blackColor]];
        [self.contentView addSubview:self.separatorView];
        [_separatorView release];
    }
    return self;
}

+ (AreaSiteEnterCell *)areaSiteEnterCellWithTableView:(UITableView *)tableView{
    AreaSiteEnterCell *areaSiteEnterCell = [tableView dequeueReusableCellWithIdentifier:@"areaSiteEnterCell"];
    if (!areaSiteEnterCell) {
        areaSiteEnterCell = [[AreaSiteEnterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"areaSiteEnterCell"];
    }
    return areaSiteEnterCell;
}
- (void)setRowContent:(RowModel *)rowContent{
    if (_rowContent != rowContent) {
        [_rowContent release];
        _rowContent = [rowContent retain];
        [self.picView reloadData];
        [self.descriptionLabel setText:_rowContent.descriptionFHY];
        [self.userLabel setText:_rowContent.userName];
        [self.timeLabel setText:_rowContent.timeString];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat labelHeight = [AutoSize AutoSizeOfHeightWithText:_rowContent.descriptionFHY andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 20];
    self.picHeight = _rowContent.picArray.count ? 150 : 0;
    [self.descriptionLabel setFrame:CGRectMake(10, 10, kCellWidth - 20, labelHeight)];
    [self.picView setFrame:CGRectMake(10, 12 + labelHeight, kCellWidth - 20, self.picHeight)];
    [self.userLabel setFrame:CGRectMake(10, self.picView.frame.origin.y + self.picHeight, kCellWidth - 20, 20)];
    [self.timeLabel setFrame:CGRectMake(10, self.picView.frame.origin.y + self.picHeight, kCellWidth - 20, 20)];
    [self.separatorView setFrame:CGRectMake(10, kCellHeight - 0.35, kCellWidth - 20, 0.7)];
}

#pragma mark 返回分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark返回单元格数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _rowContent.picArray.count ? _rowContent.picArray.count : 0;
}
#pragma mark 返回单元格

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoModel *photoModel = self.rowContent.picArray[indexPath.row];
    ScrollPicViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"scrollPicViewCell" forIndexPath:indexPath];
    cell.photoModel = photoModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoEnterViewController *photoEnterViewController = [[PhotoEnterViewController alloc]init];
    NSMutableArray *photoModelArray = [NSMutableArray array];
    for (PhotoModel *tempPhoto in _rowContent.picArray) {
        PhotoPageModel *photoPageModel = [[PhotoPageModel alloc]init];
        photoPageModel.image_url = tempPhoto.photo_url;
        photoPageModel.image_width = tempPhoto.width;
        photoPageModel.image_height = tempPhoto.height;
        [photoModelArray addObject:photoPageModel];
        [photoPageModel release];
    }
    [photoEnterViewController setContentArray:photoModelArray];
    [photoEnterViewController setPhotoNumber:indexPath.row];
    [_delegate pushToPhotoViewController:photoEnterViewController];
    [photoEnterViewController release];
}

#pragma mark 单元格尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoModel *photoModel = self.rowContent.picArray[indexPath.row];
    return CGSizeMake(self.picHeight * photoModel.proportion, self.picHeight);
}
@end
