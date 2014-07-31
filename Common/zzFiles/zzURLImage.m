//

//  zzURLImage.m
//  MFMClient
//
//  Created by zzzili on 14-3-9.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import "zzURLImage.h"
#import <CommonCrypto/CommonDigest.h>


@implementation zzURLImage

+(UIImage*)GetImageFromUrl:(NSString *)url
{
    if(url == nil || url.length==0)
        return nil;
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //根据url检车本地cache内缓存文件
    NSString *localPath = [zzURLImage GetLocalPath:url];
    if(YES==[zzURLImage isFileHas:localPath])
    {
        NSData *data = [NSData dataWithContentsOfFile:localPath];
        if(data.length>0)
        {
            return [UIImage imageWithData:data];
        }
        else
        {
            return nil;
        }
    }
    else
    {
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        [data writeToFile:localPath atomically:YES];
        return [UIImage imageWithData:data];
    }
}

+(UIImage*)GetImageFromLocal:(NSString*)url
{
    if(url == nil || url.length==0)
        return nil;
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *localPath = [zzURLImage GetLocalPath:url];
    if(YES==[zzURLImage isFileHas:localPath])
    {
        NSData *data = [NSData dataWithContentsOfFile:localPath];
        if(data.length>0)
        {
            return [UIImage imageWithData:data];
        }
        else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

+(BOOL)isFileHas:(NSString*)filePath
{
    NSFileManager *fileMan = [NSFileManager defaultManager];
    return [fileMan fileExistsAtPath:filePath];
        
}

///根据url获取cache内image文件路径
+(NSString*)GetLocalPath:(NSString*)url
{
    if(url == nil || url.length==0)
        return nil;
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cache objectAtIndex:0];
    
    NSString *md5 = [zzURLImage getMd5_32Bit_String:url];
    return [NSString stringWithFormat:@"%@/%@.img",cachePath,md5];
}
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

//清除缓存图片
+(int)DeleteAllCacheFile
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cache objectAtIndex:0];
    
    NSArray *array = [[fileManager contentsOfDirectoryAtPath:cachePath error:nil]   pathsMatchingExtensions:[NSArray arrayWithObject:@"img"]];
    for(int i=0;i<array.count;i++)
    {
        [fileManager removeItemAtPath:[cachePath stringByAppendingPathComponent:[array objectAtIndex:i]] error:nil];
    }
    return  array.count;
}
@end

@implementation zzImageView

-(id)initWithUrl:(NSString*)url defImage:(UIImage*)defImage
{
    self = [super init];
    self.image = defImage;
    if(url == nil || url.length==0)
        return self;
    
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *localPath = [zzURLImage GetLocalPath:url];
    if(YES==[zzURLImage isFileHas:localPath])
    {
        NSData *data = [NSData dataWithContentsOfFile:localPath];
        if(data.length>0)
        {
            UIImage *image =[UIImage imageWithData:data];
            self.image = image;
        }
    }
    else
    {
        NSThread *InitThread = [[NSThread alloc]initWithTarget:self selector:@selector(InitThreadFunc:) object:url];
        [InitThread start];
    }
    return self;
}

-(id)initWithUrl:(NSString*)url
{
    self = [super init];
    self.image = [UIImage imageNamed:@"tx.png"];
    if(url == nil || url.length==0)
        return self;
    
    url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *localPath = [zzURLImage GetLocalPath:url];
    if(YES==[zzURLImage isFileHas:localPath])
    {
        NSData *data = [NSData dataWithContentsOfFile:localPath];
        if(data.length>0)
        {
          UIImage *image =[UIImage imageWithData:data];
          self.image = image;
        }
    }
    else
    {
       NSThread *InitThread = [[NSThread alloc]initWithTarget:self selector:@selector(InitThreadFunc:) object:url];
       [InitThread start];
    }
    return self;
}

-(void)InitThreadFunc:(id)sender
{
    NSString *url = sender;
    NSString *localPath = [zzURLImage GetLocalPath:url];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    if(data.length>0)
    {
        [data writeToFile:localPath atomically:YES];
        UIImage *image = [UIImage imageWithData:data];
        
        [self performSelectorOnMainThread:@selector(updateImage:) withObject:image waitUntilDone:YES];
    }
}
-(void)updateImage:(id)sender
{
    UIImage *image = sender;
    self.image = image;
}
@end
