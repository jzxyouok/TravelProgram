//
//  TableViewSectionView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/11.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "TableViewSectionView.h"
#import "Travel_Detail_Model.h"

@interface TableViewSectionView ()
@property (nonatomic,retain)UILabel *contentLabel;
@end
@implementation TableViewSectionView
- (void)dealloc
{
    [_contentLabel release];
    [_sectionViewModel release];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentLabel = [[UILabel alloc]initWithFrame:frame];
        [self.contentLabel setBackgroundColor:[UIColor whiteColor]];
        [self.contentLabel setTextAlignment:NSTextAlignmentCenter];
        [self.contentLabel setTextColor:[UIColor blackColor]];
        [self.contentLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [self addSubview:self.contentLabel];
    }
    return self;
}
- (void)setSectionViewModel:(Travel_Detail_Model *)sectionViewModel{
    if (_sectionViewModel != sectionViewModel) {
        [_sectionViewModel release];
        _sectionViewModel = [sectionViewModel retain];
        if (sectionViewModel.trip_date) {
            [self.contentLabel setText:[NSString stringWithFormat:@"Day%@  %@",sectionViewModel.day,sectionViewModel.trip_date]];
        } else {
            [self.contentLabel setText:[NSString stringWithFormat:@"Day%@",sectionViewModel.day]];
        }

    }
}
@end
