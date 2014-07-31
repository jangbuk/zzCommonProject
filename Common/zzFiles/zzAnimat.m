//
//  NSObject+zzAnimat.m
//  MuBao3
//
//  Created by Ji Lucky on 13-2-21.
//  Copyright (c) 2013年 Ji Lucky. All rights reserved.
//

#import "zzAnimat.h"

@implementation zzAnimat

+(void)ZAMoveView:(UIView*)view  oldFrame:(CGRect)_old  newFrame:(CGRect)_new time:(float)_time
{
    [view setFrame:_old];
    [UIView beginAnimations:nil context:(__bridge void *)(view)];
    [UIView setAnimationDuration:_time];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(imageViewDidStop:finished:context:)];
    [view setFrame:_new];
    [UIView commitAnimations];
}

+(void)ZAZoomView:(UIView*)view oldScale:(float)_old newScale:(float)_new time:(float)_time
{
    view.center = view.center;
    view.transform = CGAffineTransformMakeScale(_old, _old);//CGAffineTransformIdentity;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:_time];
    view.transform = CGAffineTransformMakeScale(_new, _new);
    [UIView commitAnimations];
}

+(void)ZARotateView:(UIView *)view angle:(float)_angle time:(float)_time
{
    view.center = view.center;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:_time];
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDelegate:self];
   // [UIView setAnimationDidStopSelector:@selector(imageViewDidStop:finished:context:)];
    view.transform =CGAffineTransformMakeRotation((_angle * M_PI) / 180.0f);
    [UIView commitAnimations];
}
- (void)imageViewDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
       
}

@end
