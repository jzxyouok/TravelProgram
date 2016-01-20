//
//  ClickImageView.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/23.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "ClickImageView.h"
#import "RemoveView.h"
#define kWindowWidth [[UIScreen mainScreen] bounds].size.width
#define kWindowHeight [[UIScreen mainScreen] bounds].size.height
@implementation ClickImageView

- (instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    RemoveView *photoView = [[RemoveView alloc]initWithFrame:CGRectMake(0, 0, kWindowWidth, kWindowHeight)];
    [photoView setBackgroundColor:[UIColor blackColor]];
    UIImageView *copySelf = [[UIImageView alloc]initWithImage:self.image];
    [copySelf setTag:654321];
    [copySelf setUserInteractionEnabled:NO];
    [copySelf setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [copySelf setCenter:photoView.center];
    [photoView addSubview:copySelf];
    [copySelf release];
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    [saveBtn setFrame:CGRectMake(kWindowWidth - 55, kWindowHeight - 70, 25, 22)];
    [saveBtn addTarget:self action:@selector(tapSaveImageToIphone) forControlEvents:UIControlEventTouchUpInside];
    [photoView addSubview:saveBtn];
    [[[UIApplication sharedApplication]keyWindow] addSubview:photoView];
    [photoView release];
}
- (void)tapSaveImageToIphone{
    
    /**
     *  将图片保存到iPhone本地相册
     *  UIImage *image            图片对象
     *  id completionTarget       响应方法对象
     *  SEL completionSelector    方法
     *  void *contextInfo
     */
    UIImageWriteToSavedPhotosAlbum([(UIImageView *)[[[UIApplication sharedApplication]keyWindow] viewWithTag:654321] image], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
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

@end
