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
        self.sqlite = [[CSqlite alloc]init];
        [self.sqlite openSqlite:@"db.sqlite"];
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

//从sqlite数据库读取数据
-(NSMutableArray*)readDataFromSqlite
{
    NSMutableArray *list = [[NSMutableArray alloc]init];
    
    NSString *sql = @"select * from ztable";
    NSArray *array = [self.sqlite NSSelectData:sql];
    for(int i=0;i<array.count;i++)
    {
        NSDictionary *dic = [array objectAtIndex:i];
        SqlNode *node = [[SqlNode alloc]init];
        node.t1 = [dic objectForKey:@"t1"];
        node.t2 = [dic objectForKey:@"t2"];
        
        [list addObject:node];
    }
    
    return list;
}
@end
