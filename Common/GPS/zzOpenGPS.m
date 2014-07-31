//
//  zzOpenGPS.m
//  MFMClient
//
//  Created by zzzili on 14-2-16.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import "zzOpenGPS.h"

@implementation zzOpenGPS

////打开GPS
- (void)OpenGPS
{
    if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter=0.5;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation]; // 开始定位
        
    }
    
    NSLog(@"GPS 启动");
    _nowLocationBaidu.latitude = 34.782257;
    _nowLocationBaidu.longitude = 113.775182;
}

// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    _nowLocationWGS.latitude = newLocation.coordinate.latitude;
    _nowLocationWGS.longitude = newLocation.coordinate.longitude;
    self.height = newLocation.altitude;
    //////////纠偏
    

    /////////获取位置信息
    CLLocation *gcjlocation = [[CLLocation alloc]initWithLatitude:_nowLocationGCJ.latitude longitude:_nowLocationGCJ.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:gcjlocation completionHandler:^(NSArray* placemarks,NSError *error)
     {
         if (placemarks.count >0   )
         {
             CLPlacemark * plmark = [placemarks objectAtIndex:0];
             self.nowLocationStr = [[NSString alloc]initWithFormat:@"%@%@",plmark.locality,plmark.thoroughfare];
             [self.locationManager stopUpdatingLocation];
             
             [self.delegate GetNewGPS];
         }
     }];
    
}
// 定位失败时调用
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"定位失败");
}

@end
