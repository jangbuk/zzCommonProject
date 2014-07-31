//
//  zzCache.m
//  MFMClient
//
//  Created by zzzili on 14-3-15.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import "zzCache.h"

@implementation zzCache

+(BOOL)WiriteStringToFile:(NSString*)fileName dataStr:(NSString*)dataStr
{
    if(dataStr==nil||fileName==nil)
        return NO;
    NSString *filePath = [zzCache GetFileDocPath:[NSString stringWithFormat:@"%@.yfch",fileName]];
    [dataStr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return YES;
}

+(NSString*)ReadStringFromFile:(NSString*)fileName
{
    NSString *filePath = [zzCache GetFileDocPath:[NSString stringWithFormat:@"%@.yfch",fileName]];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]==NO)
        return nil;
    
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    return str;
}

+(int)DeleteAllCacheFile
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray *array = [[fileManager contentsOfDirectoryAtPath:[zzCache GetFileDocPath:@""]error:nil]   pathsMatchingExtensions:[NSArray arrayWithObject:@"yfch"]];
    for(int i=0;i<array.count;i++)
    {
        [fileManager removeItemAtPath:[zzCache GetFileDocPath:[array objectAtIndex:i]] error:nil];
    }
    return  array.count;
}
+(NSString*)GetFileDocPath:(NSString*)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:fileName];
}
@end
