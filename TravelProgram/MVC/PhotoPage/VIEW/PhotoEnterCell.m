//
//  PhotoEnterCell.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
#define kCellWidth self.contentView.frame.size.width
#define kCellHeight self.contentView.frame.size.height
#import "PhotoEnterCell.h"
#import "PhotoPageModel.h"
@interface PhotoEnterCell ()
@property (nonatomic,retain)UIView *backView;
@property (nonatomic,retain)UIImageView *picView;
@property (nonatomic,retain)UIButton *saveBtn;
@end
@implementation PhotoEnterCell
- (void)dealloc
{
    [_saveBtn release];
    [_backView release];
    [_picView release];
    [_cellContent release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView setUserInteractionEnabled:YES];
        self.backView = [[UIView alloc]init];
        [self.backView setBackgroundColor:[UIColor blackColor]];
        [self.contentView addSubview:self.backView];
        self.picView = [[UIImageView alloc]init];
        [self.backView addSubview:self.picView];
        [_picView release];
        
        self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.saveBtn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
        [self.saveBtn addTarget:self action:@selector(tapSaveImageToIphone) forControlEvents:UIControlEventTouchUpInside];
        [self.backView addSubview:self.saveBtn];
        [_saveBtn release];
    }
    return self;
}
- (void)tapSaveImageToIphone{
    
    /**
     *  将图片保存到iPhone本地相册
     *  UIImage *image            图片对象
     *  id completionTarget       响应方法对象
     *  SEL completionSelector    方法
     *  void *contextInfo
     */
    UIImageWriteToSavedPhotosAlbum(self.picView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}
- (void)setCellContent:(PhotoPageModel *)cellContent{
    if (_cellContent != cellContent) {
        [_cellContent release];
        _cellContent = [cellContent retain];
        [self.picView setBackgroundColor:[UIColor whiteColor]];
        [self.picView sd_setImageWithURL:[NSURL URLWithString:_cellContent.image_url] placeholderImage:[UIImage imageNamed:@"placeHolder_2"]];
        [self.picView setFrame:CGRectMake(0, 0, kCellWidth,kCellWidth * ([_cellContent.image_height floatValue] / [_cellContent.image_width floatValue]))];
        [self.picView setCenter:CGPointMake(kCellWidth / 2, kCellHeight / 2)];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.backView setFrame:CGRectMake(0, 0, kCellWidth, kCellHeight)];
    [self.saveBtn setFrame:CGRectMake(kCellWidth - 55, kCellHeight - 70, 25, 22)];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [_delegate popBack];
}

@end
