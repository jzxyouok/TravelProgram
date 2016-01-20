//
//  GoMapViewController.m
//  TravelProgram
//
//  Created by 付寒宇 on 15/10/19.
//  Copyright (c) 2015年 付寒宇. All rights reserved.
//

#import "GoMapViewController.h"
#define kWidth self.view.frame.size.width
#define kHeight self.view.frame.size.height
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "AreaSiteCustomNavBar.h"
@interface GoMapViewController ()<MKMapViewDelegate>
@property (nonatomic,retain)AreaSiteCustomNavBar *customBar;
@property (nonatomic,retain)CLLocationManager *locationManager;
@property (nonatomic,retain)MKMapView *mapView;
@end

@implementation GoMapViewController
- (void)dealloc
{
    [_name release];
    [_customBar release];
    [_locationManager release];
    [_mapView release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect=[UIScreen mainScreen].bounds;
    self.mapView=[[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:self.mapView];
    [_mapView release];
    //设置代理
    _mapView.delegate = self;
    
    
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode = MKUserTrackingModeNone;
    
    //设置地图类型
    _mapView.mapType = MKMapTypeStandard;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(_lat, _lng), 700, 700);
    
    //重新设置地图视图的显示区域
    [_mapView setRegion:viewRegion animated:YES];
    //添加大头针
    [self addAnnotation];
    //创建自定义navBar
    [self createCustomBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark 添加大头针
-(void)addAnnotation{
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(_lat,_lng);
    Annotation *annotation=[[Annotation alloc]init];
    annotation.title = _name;
    annotation.coordinate = location;
    [_mapView addAnnotation:annotation];
    [annotation release];
}
#pragma mark mapView Delegate 地图 添加大头针时回调
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView * annotationView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN_ANNOTATION"];
    }
    annotationView.pinColor = MKPinAnnotationColorRed ;
    annotationView.animatesDrop = YES ;
    annotationView.canShowCallout = YES ;
    annotationView.selected = YES;
    return annotationView;
}
//创建自定义bar
- (void)createCustomBar{
    self.customBar = [[AreaSiteCustomNavBar alloc]initWithFrame:CGRectMake(0, 0, kWidth, 64)];
    [self.customBar.titleView setText:_name];
    [self.customBar.backButton addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.customBar];
    [_customBar release];
}
- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
