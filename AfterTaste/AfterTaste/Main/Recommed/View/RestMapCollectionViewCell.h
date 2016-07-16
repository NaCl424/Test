//
//  RestMapCollectionViewCell.h
//  AfterTaste
//
//  Created by mac on 16/7/7.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import "MapRestCollectionView.h"


@interface RestMapCollectionViewCell : UICollectionViewCell<BMKLocationServiceDelegate,BMKMapViewDelegate>

{
    
    BMKLocationService *_locService;
    BMKMapView* _mapView;
    NSInteger _selectedAnnIndex;
    MapRestCollectionView * _restCollView;
    
    
}


@property(nonatomic, copy) NSDictionary *dataDic;

@end
