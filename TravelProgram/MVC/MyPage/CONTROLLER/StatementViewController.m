//
//  StatementViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/22.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "StatementViewController.h"
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import "AreaEnterNavigationBar.h"
@interface StatementViewController ()
@property (nonatomic,retain)AreaEnterNavigationBar *customBar;
@end

@implementation StatementViewController
- (void)dealloc
{
    [_customBar release];
    [super dealloc];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setHidesBottomBarWhenPushed:YES];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //创建自定义navBar
    [self createCustomBar];
    UILabel *statementLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 66,kWidth - 60 , 150)];
    [statementLabel setNumberOfLines:0];
    [statementLabel setFont:[UIFont systemFontOfSize:14]];
    [statementLabel setText:@"行者日记在此声明,您通过本软件参与的任何商业活动,与Apple Inc.无关\n\n本软件资源取自互联网,如有侵权请联络反馈问题邮箱,我们将立即进行删除,感谢您的理解."];
    [self.view addSubview:statementLabel];
    [statementLabel release];
}
//创建自定义bar
- (void)createCustomBar{
    self.customBar = [[AreaEnterNavigationBar alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.customBar.titleView setText:@"特别声明"];
    [self.customBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customBar];
    [_customBar release];
}
- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
