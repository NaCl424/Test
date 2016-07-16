//
//  AppDelegate.h
//  AfterTaste
//
//  Created by mac on 16/6/29.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager* _mapManager;
    
}
@property (strong, nonatomic) UIWindow *window;


@end

