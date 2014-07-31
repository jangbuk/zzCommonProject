//
//  zzViewController.m
//  MFMClient
//
//  Created by zzzili on 14-2-16.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import "zzViewController.h"

@interface zzViewController ()

@end

@implementation zzViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    UIColor *circleColorPattern = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];//[UIColor colorWithPatternImage:
                                  // [UIImage imageNamed:@"bb.png"]];
    [self.view setBackgroundColor:circleColorPattern];
    [self SetReturnBtn];
}


-(void)SetReturnBtn
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
    //[button setTitle:@"返回" forState:UIControlStateNormal];
    //button.font = [UIFont systemFontOfSize:14];
    [button setBackgroundImage:[UIImage imageNamed:@"back2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.leftBarButtonItem = btn;
    
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -10;
    //self.navigationItem.leftBarButtonItem = btn;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, btn, nil];
}

-(UIButton*)zzCreateItemBtn
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0,0,50,25)];
    //button.font = [UIFont systemFontOfSize:14];
    [button setBackgroundImage:[UIImage imageNamed:@"right_btn_p.png"] forState:UIControlStateNormal];
    return button;
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)SetTopBarImg
{
    ///设置Top背景图片
    UIImage *topBackImg = [[UIImage imageNamed:@"top_bg.9.png"]
                           resizableImageWithCapInsets:UIEdgeInsetsMake(13,13,13,13)];
    [self.navigationController.navigationBar setBackgroundImage:topBackImg forBarMetrics:UIBarMetricsDefault];  //设置背景

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    [dic setObject:[UIFont systemFontOfSize:19] forKey:UITextAttributeFont];
    self.navigationController.navigationBar.titleTextAttributes = dic;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SetBtnBackImg:(UIButton*)btn
{
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[zzCommon GetLashenImage:@"button_green_normal.9.png" size:CGRectMake(20, 33, 20, 33)] forState:UIControlStateNormal];
}

-(void)SetBtnBackImg2:(UIButton*)btn
{
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setBackgroundImage:[zzCommon GetLashenImage:@"button_white_normal.9.png" size:CGRectMake(20, 33, 20, 33)] forState:UIControlStateNormal];
    [btn setBackgroundImage:[zzCommon GetLashenImage:@"button_black_normal.9.png" size:CGRectMake(20, 33, 20, 33)] forState:UIControlStateSelected];
}

-(void)ShowMsgInUIView:(NSString*)msg
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //toast
    //[window makeToast:msg duration:1.5 position:@"bottom"];
}

-(void)SetHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"加载中";
    
    [HUD showWhileExecuting:@selector(HUDThreadFunc) onTarget:self withObject:nil animated:YES];
}
-(void)HUDThreadFunc
{
    
}
-(void)SetHUDWithSel:(SEL)method
{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"加载中";
    
    [HUD showWhileExecuting:method onTarget:self withObject:nil animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [HUD removeFromSuperview];
    HUD = nil;
    [super viewDidDisappear:animated];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
