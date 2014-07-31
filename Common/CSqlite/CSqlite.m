//
//  CSqlite.m
//  WXS
//
//  Created by zili zhu on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CSqlite.h"

@implementation CSqlite

-(void)openSqlite:(NSString*)sqlFile
{
    NSString *databasePath = [zzCommon GetCacheDicPath:sqlFile];
  
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // Copy the database sql file from the resourcepath to the documentpath
    if (![fileManager fileExistsAtPath:databasePath])
    {
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:sqlFile];
        NSError *error;
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:&error];
    }

    sqlite3_close(database);
    if(sqlite3_open([databasePath cStringUsingEncoding:NSASCIIStringEncoding], &database)==SQLITE_OK)
    {
         NSLog(@"open sqlite db ok.");
    }
    else
    {
         NSLog(@"open sqlite db error!!!!!!!.");
        
    }
}

-(void)closeSqlite
{
    sqlite3_close(database);
}
- (void)dealloc
{
    [self closeSqlite];
}
-(sqlite3_stmt*)runSql:(char*)sql
{
   // char *errorMsg;
    sqlite3_stmt *statement; 
    if (sqlite3_prepare_v2(database, sql, -1, &statement, nil)==SQLITE_OK) { 
    }
    return statement;
}

-(sqlite3_stmt*)NSRunSql:(NSString*)sql
{
   // char *errorMsg;
    sqlite3_stmt *statement; 
    if (sqlite3_prepare_v2(database, [sql UTF8String], -1, &statement, nil)==SQLITE_OK) { 
    }
    else {
    }
    return statement;
}

-(BOOL)NSSendSql:(NSString*)sql
{
    char *errorMsg;
    if (sqlite3_exec(database, [sql UTF8String], 0, 0, &errorMsg)==SQLITE_OK)
    { 
        return YES;    
    }
    else 
    {
        fprintf(stderr,"Error:  %s",  errorMsg);
        return NO;
    }
}


-(NSArray *)NSSelectData:(NSString *)sqlStr
{
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    sqlite3_stmt *stmt;
    if (sqlite3_prepare_v2(database, [sqlStr UTF8String], -1, &stmt, nil) == SQLITE_OK)
    {
        while (sqlite3_step(stmt) == SQLITE_ROW)
        {
            int dataCount = sqlite3_column_count(stmt);
            NSMutableDictionary *dicList = [[NSMutableDictionary alloc]init];
            for (int i = 0; i <dataCount; i++)
            {
                char *rowdata = (char *)sqlite3_column_text(stmt, i);
                if (rowdata != nil)
                {
                    
                    NSString *tmpStr = [NSString stringWithCString:rowdata encoding:NSUTF8StringEncoding];
                    NSString *columnName = [NSString stringWithCString:sqlite3_column_name(stmt, i) encoding:NSUTF8StringEncoding];
                    if(tmpStr != nil)
                    {
                       [dicList setObject:tmpStr forKey:columnName];
                    }
                }
            }
            [tmpArray addObject:dicList];
        }
    }
    return tmpArray;
}

@end

