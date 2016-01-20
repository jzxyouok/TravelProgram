//
//  BSTableViewCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/8.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSTableViewCell.h"
@implementation BSTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}


- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
