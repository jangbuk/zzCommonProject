//
//  ViewController.m
//  zzProject
//
//  Created by zz on 14-7-31.
//  Copyright (c) 2014年 YunFeng. All rights reserved.
//

#import "ViewController.h"
#import "zzMoveScaleImageController.h"
#import "zzSelectDateView.h"
#import "zzPickerView.h"

@interface ViewController ()

@end

@implementation ViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//测试获取post返回数据
- (IBAction)touchGetPostMsg:(id)sender {
    LocNode *node = [g_data getStringFromPost];
    
    NSString *str = [NSString stringWithFormat:@"城市:%@ 纬度：%@  经度：%@",node.cityName,node.lat,node.lon];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

//测试图片缩放
- (IBAction)touchScrolImage:(id)sender {
    UIImage *image = [UIImage imageNamed:@"psb.jpeg"];
    
    zzMoveScaleImageController *page = [[zzMoveScaleImageController alloc]init];
    page.m_image = image;
    [self presentViewController:page animated:YES completion:nil];
}

//测试异步图片下载
- (IBAction)touchDownShowImageView:(id)sender {
    //类似SDWebImage，在uitableview中也实用
    zzImageView *imageView = [[zzImageView alloc]initWithUrl:@"http://d.hiphotos.baidu.com/image/pic/item/ca1349540923dd54bd2627e2d309b3de9d8248e7.jpg"];
    imageView.frame = CGRectMake(20, 50, 80, 100);
    [self.view addSubview:imageView];
}
//弹出时间选择器
- (IBAction)touchSelectDate:(id)sender {
    zzSelectDateView *selView = [[zzSelectDateView alloc]init];
//    selView.delegate = self;//zzSelectDateDelegate
    selView.frame = [UIScreen mainScreen].bounds;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:selView];
}
//弹出序列选择器
- (IBAction)touchSelectIndex:(id)sender {
    zzPickerView *selView = [[zzPickerView alloc]init];
    //    selView.delegate = self;//zzPickerViewDelegate
    selView.frame = [UIScreen mainScreen].bounds;
    selView.dataList = [NSArray arrayWithObjects:@"选择1",@"选择2",@"选择3",@"选择4", nil];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:selView];
    [selView initPickView];
}
@end
