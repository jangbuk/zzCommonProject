//
//  zzOpenGPS.h
//  MFMClient
//
//  Created by zzzili on 14-2-16.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol zzRefreshGPS <NSObject>

@optional
-(void)GetNewGPS;

@end

@interface zzOpenGPS : NSObject<CLLocationManagerDelegate,zzRefreshGPS>
{
}

@property (strong,nonatomic) id delegate;

@property (strong,nonatomic) CLLocationManager *locationManager;

@property (assign,nonatomic) CLLocationCoordinate2D nowLocationWGS;
@property (assign,nonatomic) CLLocationCoordinate2D nowLocationGCJ;
@property (assign,nonatomic) CLLocationCoordinate2D nowLocationBaidu;

@property (strong,nonatomic) NSString *nowLocationStr;

@property (assign,nonatomic) double height;

- (void)OpenGPS;

@end
