//
//  zzData.m
//  zzMJM
//
//  Created by zzzili on 14-2-11.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import "zzData.h"

#import "DataClass.h"
//#import "NSData+Base64.h"
#import <Foundation/NSData.h>



@implementation zzData

-(id)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

-(LocNode *)getStringFromPost
{
    //post接口地址
    NSString *urlStr = @"http://gc.ditu.aliyun.com/geocoding";
    //post传的参数
    NSString *dataStr = @"a=苏州市";
    //获取返回的json格式字符串
    NSString *jsonstr = [self GetReturnFromPost:urlStr postData:dataStr];
    //json字符串转未数据字典
    NSDictionary *dic = [self GetDictionaryWithJson:jsonstr];
    //KVC，数据字典转实体类
    LocNode *node = [[LocNode alloc]init];
    [node setValuesForKeysWithDictionary:dic];
    
    return node;
}

@end
