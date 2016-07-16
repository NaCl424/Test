//
//  RestMapCollectionViewCell.m
//  AfterTaste
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "RestMapCollectionViewCell.h"

@implementation RestMapCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        [self createMapView];
    }
    return self;
}

- (void)createMapView {
    
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _mapView = [[BMKMapView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:_mapView];
    _mapView.delegate = self;
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    _mapView.isSelectedAnnotationViewFront = YES;
    
    
    
    //创建餐厅collectionView
    _restCollView = [[MapRestCollectionView alloc] initWithFrame:CGRectMake(0,kScreenHeight - 110 - 64 - 50 , kScreenWidth, 100) withItemSize:CGSizeMake(kScreenWidth - 40, 90)];
    
    //滑动的block回调
    __weak id weakSelf = self;
    __weak BMKMapView *weakMap = _mapView;
   
    _restCollView.indexChangedBlock = ^(NSUInteger index){
        __strong id strongSelf = weakSelf;
        __strong BMKMapView *strongMap = weakMap;
        [strongSelf moveToSelectedAnnotationAtIndex:index];
        
        BMKPointAnnotation *selectAnnotation = strongMap.annotations[index];
        
        [strongMap selectAnnotation:selectAnnotation animated:NO];
    };
    
    [self.contentView addSubview:_restCollView];
    
    
    //添加定位按钮,点击将用户位置居中
    UIButton * locationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationButton setBackgroundImage:[UIImage imageNamed:@"map_getlocation_yellow"] forState:UIControlStateNormal];
    locationButton.frame = CGRectMake(kScreenWidth - 50, kScreenHeight - 110 - 64 -50 - 50, 40 , 40 );
    [locationButton addTarget:self action:@selector(moveToUserLocation) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:locationButton];
}

- (void)dealloc {

    
    [_locService stopUserLocationService];

}

//设置DataDic后 要刷新标注
- (void)setDataDic:(NSDictionary *)dataDic {
    
    if (_dataDic == dataDic) {
        
        return;
    }
    _dataDic = dataDic;
    
    [self addAnnotations];
    
}

- (void)addAnnotations {

    //设置标注
    NSDictionary *restListDic = _dataDic[@"restlist"];
    NSArray * listArray = restListDic[@"list"];

    //把原来的标注移除
    [_mapView removeAnnotations:_mapView.annotations];
    for (int i = 0; i < listArray.count; i++) {
        
        NSDictionary *restDic = listArray[i];
        BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [restDic[@"lat"] floatValue];
        coor.longitude = [restDic[@"lng"] floatValue];
        annotation.coordinate = coor;
        annotation.title = restDic[@"name"];
        [_mapView   addAnnotation:annotation];
    }
    [self  moveToSelectedAnnotationAtIndex:0];

    //设置下面滑动视图
    _restCollView.restList = listArray;

    //移动到第一个标注
    [self moveToSelectedAnnotationAtIndex:0];
    [_mapView selectAnnotation:[_mapView.annotations firstObject] animated:NO];
}

//当前位置居中
- (void)moveToUserLocation {
    
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(_locService.userLocation.location.coordinate, BMKCoordinateSpanMake(0.2, 0.2));
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    [_mapView setRegion:adjustedRegion animated:YES];
    
    
}

//跳转到选中的标记
- (void)moveToSelectedAnnotationAtIndex:(NSUInteger) index {
    
    if ( index >=_mapView.annotations.count ) {
        return;
    }
    
    BMKPointAnnotation *selectedAnnotation = _mapView.annotations[index];
    
    BMKCoordinateRegion viewRegion = BMKCoordinateRegionMake(selectedAnnotation.coordinate, BMKCoordinateSpanMake(0.2, 0.2));
    BMKCoordinateRegion adjustedRegion = [_mapView regionThatFits:viewRegion];
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
}

#pragma mark - BMKLocationServiceDelegate

/*用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    
    //显示定位
    _mapView.showsUserLocation = YES;
    [_mapView updateLocationData:userLocation];
    
    
}


//创建标记调用
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
        if (newAnnotationView == nil) {
            
            newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
        }
        
        newAnnotationView.image = [UIImage imageNamed:@"rest_unselect"];
        
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        
        return newAnnotationView;
    }
    
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view {
    
    BMKPointAnnotation *annotation = [view annotation];
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
    
        view.image = [UIImage imageNamed:@"rest_select"];
        NSInteger index =  [mapView.annotations indexOfObject:annotation];
        [self moveToSelectedAnnotationAtIndex:index];
        
        [_restCollView scrollToItemAtIndex:index];
    }
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view {
    
    BMKPointAnnotation *annotation = [view annotation];

    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
    
        view.image = [UIImage imageNamed:@"rest_unselect"];
    }
    
    
}



@end
