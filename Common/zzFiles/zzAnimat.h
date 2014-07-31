//
//  NSObject+zzAnimat.h
//  MuBao3
//
//  Created by Ji Lucky on 13-2-21.
//  Copyright (c) 2013年 Ji Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zzAnimat:NSObject
//移动
+(void)ZAMoveView:(UIView*)view  oldFrame:(CGRect)_old  newFrame:(CGRect)_new time:(float)_time;
//缩放
+(void)ZAZoomView:(UIView*)view oldScale:(float)_old newScale:(float)_new time:(float)_time;
//旋转
+(void)ZARotateView:(UIView *)view angle:(float)_angle time:(float)_time;
@end
