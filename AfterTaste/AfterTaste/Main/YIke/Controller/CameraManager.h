//
//  CameraManager.h
//  AfterTaste
//
//  Created by 林林 on 16/7/7.
//  Copyright © 2016年 lhn. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  闪光灯模式
 */
typedef NS_ENUM(NSInteger, CameraManagerFlashMode) {
    
    CameraManagerFlashModeAuto, //自动
    
    CameraManagerFlashModeOff, //关闭
    
    CameraManagerFlashModeOn //打开
};

/**
 *  摄像头模式
 */
typedef NS_ENUM(NSInteger, CameraManagerDevicePosition) {
    
    CameraManagerDevicePositionBack, //后摄像头
    
    CameraManagerDevicePositionFront //前摄像头
};

@interface CameraManager : NSObject
//    摄像头位置
@property (nonatomic , assign) CameraManagerDevicePosition position;
//    闪光灯模式
@property (nonatomic , assign) CameraManagerFlashMode flashMode;


- (id)initWithFrame:(CGRect)frame superview:(UIView *)superview;
//    设置对焦的图片
- (void)setfocusImage:(UIImage *)focusImage;

- (void)startCamera;

- (void)stopCamera;
//    拍照
- (void)snapshotSuccess:(void(^)(UIImage *image))success
        snapshotFailure:(void (^)(void))failure;


//    添加滤镜组
- (void)addFilters:(NSArray *)filters;
//    设置滤镜
- (void)setFilterAtIndex:(NSInteger)index;
@end
