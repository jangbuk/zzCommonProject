//
//  zzMoveScaleImageController.m
//  Aipu3
//
//  Created by Ji Lucky on 13-3-4.
//  Copyright (c) 2013年 Ji Lucky. All rights reserved.
//

#import "zzMoveScaleImageController.h"

@interface zzMoveScaleImageController ()

@end

@implementation zzMoveScaleImageController

@synthesize myScrollView;
@synthesize myImageView;

//-(void)dealloc{
//    [myScrollView release];
//    [myImageView release];
//    [super dealloc];
//}

-(void)loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self clickEvent];
}

-(void)clickEvent
{
    CGFloat W = self.view.frame.size.width;//1024
    CGFloat H = self.view.frame.size.height-64;//748
    
    
   // NSLog(@"***********clickeventad");
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, W, H)];
    if(self.myScrollView==nil)
    {
        UIScrollView *scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
        self.myScrollView=scrollView;
//        [scrollView release];
    }
    self.myScrollView.backgroundColor=[UIColor blackColor];
    self.myScrollView.delegate=self;
    self.myScrollView.multipleTouchEnabled=YES;
    self.myScrollView.minimumZoomScale=1.0;
    self.myScrollView.maximumZoomScale=10.0;
    [self.view addSubview:self.myScrollView];
    
    UIImage *_image = m_image;//[UIImage imageNamed:imageFile];

    
    CGFloat iW;
    CGFloat iH;
    
    iH = H;
    iW = (iH/_image.size.height)*_image.size.width;
    if(iW>W)
    {
        iW = W;
        iH = (iW/_image.size.width)*_image.size.height;
    }
   
  
    myImageView = [UIButton buttonWithType:UIButtonTypeCustom];
    myImageView.frame = CGRectMake((W-iW)/2, (H-iH)/2, iW, iH);
    
    
    UIImage *originImage=[[UIImage alloc]initWithCGImage:_image.CGImage];
    [myImageView setImage:originImage forState:UIControlStateNormal];
   
    [myImageView addTarget:self action:@selector(closeEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.myScrollView addSubview:self.myImageView];
    
}

-(void)closeEvent:(id)sender{
   
    [self ZAZoomView:myImageView oldScale:self.myScrollView.zoomScale newScale:1.5 time:0.5];
    
}

#pragma mark UIScrollView delegate methods
//实现图片的缩放
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    //NSLog(@"**************viewForZoomingInScrollView");
    return self.myImageView;
}
//实现图片在素芳过程中居中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    self.myImageView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{  
    return YES;
}

-(void)ZAZoomView:(UIView*)view oldScale:(float)_old newScale:(float)_new time:(float)_time
{
    view.center = view.center;
    view.transform = CGAffineTransformMakeScale(_old, _old);//CGAffineTransformIdentity;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:_time];
    view.transform = CGAffineTransformMakeScale(_new, _new);
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(imageViewDidStop:finished:context:)];
    [UIView commitAnimations];
}
- (void)imageViewDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
//    self.view.hidden = YES;
//    [self dismissViewControllerAnimated:YES completion:nil];
       
}
@end
