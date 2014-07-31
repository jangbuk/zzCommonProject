//
//  zzData.h
//  zzMJM
//
//  Created by zzzili on 14-2-11.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//
#import "JSONKit.h"
#import <Foundation/Foundation.h>
#import "GlobalData.h"
#import "DataClass.h"
#import "CSqlite.h"

@interface zzData : zzCommon

@property (strong,nonatomic) CSqlite *sqlite;

-(LocNode *)getStringFromPost;

-(NSMutableArray*)readDataFromSqlite;

@end
