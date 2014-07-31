//
//  zzCache.h
//  MFMClient
//
//  Created by zzzili on 14-3-15.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zzCache : NSObject

+(BOOL)WiriteStringToFile:(NSString*)fileName dataStr:(NSString*)dataStr;

+(NSString*)ReadStringFromFile:(NSString*)fileName;

+(int)DeleteAllCacheFile;
@end
