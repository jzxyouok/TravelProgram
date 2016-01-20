//
//  LeftView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/20.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "LeftView.h"
#import "LeftViewTableViewCell.h"
#define kWidth self.frame.size.width
#define kHeight self.frame.size.height
@interface LeftView ()<UITableViewDataSource,UITableViewDelegate>
@end
@implementation LeftView
- (void)dealloc
{
    [_leftTableView release];
    [_bigButton release];
    [_titileArray release];
    [_nsIndexPathArray release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bigButton setFrame:CGRectMake(frame.size.width / 2, 0, frame.size.width / 2, frame.size.height)];
        [self.bigButton setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.bigButton];
        
        [self setBackgroundColor:[UIColor clearColor]];
        self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width / 2, frame.size.height) style:UITableViewStylePlain];
        [self.leftTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.leftTableView setBackgroundColor:[UIColor blackColor]];
        [self.leftTableView setScrollsToTop:NO];
        [self.leftTableView registerClass:[LeftViewTableViewCell class] forCellReuseIdentifier:@"leftViewTableViewCell"];
        [self.leftTableView setDelegate:self];
        [self.leftTableView setDataSource:self];
        [self addSubview:self.leftTableView];
        [_leftTableView release];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titileArray.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth / 2, 50)];
    [titleLabel setBackgroundColor:[UIColor blackColor]];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    [titleLabel setText:@"快速索引栏"];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    return titleLabel;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftViewTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleContent = [NSString stringWithFormat:@"%ld.%@",indexPath.row + 1,_titileArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *temp = _nsIndexPathArray[indexPath.row];
    [_delegate scrollTo:temp];
}
- (void)setTitileArray:(NSArray *)titileArray{
    if (_titileArray != titileArray) {
        [_titileArray release];
        _titileArray = [titileArray retain];
        [self.leftTableView reloadData];
    }
}
@end
