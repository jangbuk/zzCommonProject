//
//  zzCommon.h
//  XingKeHui
//
//  Created by zzzili on 13-3-6.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS7 (([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)?YES:NO)

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define ViewFrame  CGRectMake(0, 0, 320, 460)
#define Iphone5ViewFrame   CGRectMake(0, 0, 320, 604)

#import <Foundation/Foundation.h>
#import "zzViewController.h"
#import "zzSelectDateView.h"
#import "SVPullToRefresh.h"
#import "zzAnimat.h"
#import "MBProgressHUD.h"
#import "zzCache.h"
#import "zzURLImage.h"
#import "RESideMenu.h"
#import "CSqlite.h"
#import "zzLineLabel.h"

@interface zzCommon : NSObject


-(NSDictionary*)GetDictionaryWithJson:(NSString*)jsonStr;

-(NSArray*)GetArrayWithJson:(NSString*)jsonStr;

-(NSString *)GetReturnFromPost:(NSString*)urlStr  postData:(NSString*)_postData;

-(NSString *)GetReturnFromGET:(NSString*)urlStr;

+(UIImage*)GetLashenImage:(NSString*)imageName size:(CGRect)_size;

+(void)SetViewBorder:(UIView*)view;

+(NSString*)Date2String:(NSDate*)date;

+(NSDate*)String2Date:(NSString*)dateStr formatStr:(NSString*)formatStr;

+(NSString*)GetWeek:(NSDate*)date;

+(int)GetDayNumOf2Date:(NSDate*)startDay endDay:(NSDate*)endDay;

+(void)zzLog:(NSString*)str;
+(void)zzDelLog;

+(CGSize)GetStringSize:(NSString *)str  font:(UIFont*)_font  ConWidth:(int)_width;

+(NSString*)GetCacheDicPath:(NSString*)fileName;

@end
