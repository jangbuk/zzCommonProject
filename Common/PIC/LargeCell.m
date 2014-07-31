//
//  LargeCell.m
//  Chaofan
//
//  Created by Ren Guohua on 13-11-27.
//  Copyright (c) 2013年 yunfeng. All rights reserved.
//

#import "LargeCell.h"

@implementation LargeCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addViews];
       // [self addTap];
    }
    return self;
}



-(void)addViews
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    _scrollView.maximumZoomScale = 3.0f;
    _scrollView.minimumZoomScale = 1.0f;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.userInteractionEnabled = YES;
    [_scrollView addSubview:_imageView];
    

}


-(void)hidTextView
{
    _textView.hidden = YES;
}

-(void)showTextView
{

    _textView.hidden = NO;
}

/* 在scrollview中Zoom的目标视图 */

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return _imageView;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _scrollView.zoomScale = 1.0f;
}


/* scrollview将要开始Zooming */
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    NSLog(@"Begin Zooming");
}

/* scrollview已经发生了Zoom事件 */
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    if (scrollView.zoomScale > 1) {
        _imageView.center = CGPointMake(scrollView.contentSize.width / 2, scrollView.contentSize.height / 2);
    }
    else {
        _imageView.center = scrollView.center;
    }
    
}

/* scrollview完成Zooming */
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if (scrollView.zoomScale > 1) {
        view.center = CGPointMake(scrollView.contentSize.width / 2, scrollView.contentSize.height / 2);
    }
    else {
        view.center = scrollView.center;
    }
}
@end
