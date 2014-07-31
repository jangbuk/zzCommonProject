//
//  zzURLImage.h
//  MFMClient
//
//  Created by zzzili on 14-3-9.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zzURLImage : NSObject
+(UIImage*)GetImageFromUrl:(NSString *)url;
+(UIImage*)GetImageFromLocal:(NSString*)url;
@end

@interface zzImageView : UIImageView
-(id)initWithUrl:(NSString*)url;
-(id)initWithUrl:(NSString*)url defImage:(UIImage*)defImage;
+(int)DeleteAllCacheFile;
@end