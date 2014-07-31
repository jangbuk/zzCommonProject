//
//  DataClass.h
//  zzMJM
//
//  Created by zzzili on 14-2-13.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocNode : NSObject
@property (strong,nonatomic) NSString *cityName;
@property (strong,nonatomic) NSNumber *alevel;
@property (strong,nonatomic) NSNumber *level;
@property (strong,nonatomic) NSNumber *lon;
@property (strong,nonatomic) NSNumber *lat;
@property (strong,nonatomic) NSString *address;
@end

@interface SqlNode : NSObject
@property (strong,nonatomic) NSString *t1;
@property (strong,nonatomic) NSNumber *t2;
@end
