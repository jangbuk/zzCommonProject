//
//  zzMoveScaleImageController.h
//  Aipu3
//
//  Created by Ji Lucky on 13-3-4.
//  Copyright (c) 2013年 Ji Lucky. All rights reserved.
//
///////手势控制图片的放大缩小
#import <UIKit/UIKit.h>
@interface zzMoveScaleImageController : zzViewController<UIScrollViewDelegate>{
    UIScrollView *myScrollView;
    UIButton *myImageView;
}
@property(retain,nonatomic)UIScrollView *myScrollView;
@property(retain,nonatomic)UIButton *myImageView;

@property (strong,nonatomic) UIImage *m_image;

@end
