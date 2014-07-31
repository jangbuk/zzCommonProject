//
//  UIImage+zzCutImage.m
//  test
//
//  Created by HeHe on 14-4-29.
//  Copyright (c) 2014年 IOS. All rights reserved.
//

#import "UIImage+zzCutImage.h"

@implementation UIImage (zzCutImage)

///zzzili切割图片
-(UIImage *)zzCutImage:(CGSize)cutSize
{
    float iW = cutSize.width;
    float iH = (iW/self.size.width)*self.size.height;
    
    int cutW = cutSize.width;
    int cutH = cutSize.height;
    
    [self reSizeImage:CGSizeMake(iW, iH)];
    
    [self CutImage:CGSizeMake(cutW, cutH)];
    
    return self;
}

///图片缩放到size
- (void)reSizeImage:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIGraphicsEndImageContext();
}

//切割图片
-(void)CutImage:(CGSize)cutSize
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, CGRectMake(0, 0, cutSize.width, cutSize.height));
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIGraphicsEndImageContext();
}

//缩放比例
- (void)scaleImage:(float)scaleSize

{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scaleSize, self.size.height * scaleSize)];
    UIGraphicsEndImageContext();
}

@end
