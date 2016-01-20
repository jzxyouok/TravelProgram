//
//  BSViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/7.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSViewController.h"

@interface BSViewController ()
@end

@implementation BSViewController
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self setNeedsStatusBarAppearanceUpdate];
    [self.view setBackgroundColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
