//
//  BSUITabBarController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/7.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "BSUITabBarController.h"
#import "HomePageViewController.h"
#import "TopicViewController.h"
#import "AreaPageViewController.h"
@interface BSUITabBarController ()

@end

@implementation BSUITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有子视图控制器
    [self setUpAllChildViewController];
    
}

- (void)setUpAllChildViewController{
    HomePageViewController *homePageViewController = [[HomePageViewController alloc]init];
    [self setUpOneChildViewController:homePageViewController image:[UIImage imageNamed:@"ictab_homepage"] andSelectedImage:[UIImage imageNamed:@"ictab_homepage_selected"] andTitle:@"行记"];
    [homePageViewController release];
    
    TopicViewController *topicPageViewController = [[TopicViewController alloc]init];
    [self setUpOneChildViewController:topicPageViewController image:[UIImage imageNamed:@"ictab_favourite"] andSelectedImage:[UIImage imageNamed:@"ictab_favourite_selected"] andTitle:@"专题"];
    [topicPageViewController release];

    AreaPageViewController *areaPageViewController = [[AreaPageViewController alloc]init];
    [self setUpOneChildViewController:areaPageViewController image:[UIImage imageNamed:@"ictab_site"] andSelectedImage:[UIImage imageNamed:@"ictab_site"] andTitle:@"目的地"];
    [areaPageViewController release];
}
//创建一个UINavigationController并用UIViewController的数据初始化并添加为UITabBarController的子视图控制器
- (void)setUpOneChildViewController:(UIViewController *)viewController image:(UIImage *)image andSelectedImage:(UIImage *)selectedImage andTitle:(NSString *)title{
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
    [navC.tabBarItem setImage:image];
    [navC.tabBarItem setSelectedImage:selectedImage];
    [navC.navigationBar setHidden:YES];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40,35)];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [viewController.navigationItem setTitleView:titleLabel];
    [titleLabel release];
    [navC setTitle:title];
    [self addChildViewController:navC];
    [navC release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
