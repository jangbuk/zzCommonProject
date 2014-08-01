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
    self.navigationItem.title = @"演示";
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
    [self.baseScroll addSubview:imageView];
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
//给uiview描边框
- (IBAction)touchBiankuang:(id)sender {
    [zzCommon SetViewBorder:self.btnBiankuang];
}
//根基字符串计算label尺寸
- (IBAction)touchLabelSize:(id)sender {
    NSString *str = @"中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国中华人民共和国";
    
    CGRect frame = self.sizeLabel.frame;
    CGSize size = [zzCommon GetStringSize:str font:self.sizeLabel.font ConWidth:frame.size.width];
    frame.size.height = size.height;
    self.sizeLabel.text = str;
    self.sizeLabel.frame = frame;
}
//简单的动画
- (IBAction)touchAnimation:(id)sender {
    [zzAnimat ZAMoveView:self.sizeLabel oldFrame:self.sizeLabel.frame newFrame:CGRectMake(0, 0, 200, 30) time:0.7];
}
//获取当前时间
- (IBAction)touchGetTime:(id)sender {
    NSString *str = [zzCommon Date2String:[NSDate date]];
    [self.btnTime setTitle:str forState:UIControlStateNormal];
}
//从sqlite数据库读取数据
- (IBAction)touchOpenSqlite:(id)sender {
    NSMutableArray *list = [g_data readDataFromSqlite];
    
    NSMutableString *str = [[NSMutableString alloc]init];
    for(int i=0;i<list.count;i++)
    {
        SqlNode *node = [list objectAtIndex:i];
        [str appendFormat:@"t1:%@  t2:%@\r\n",node.t1,node.t2];
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

////自定义系统状态栏
- (IBAction)touchProcess:(id)sender {
    ///隐藏系统状态栏
    UIApplication *app = [UIApplication sharedApplication];
    //[app setStatusBarHidden:YES withAnimation:YES];
    [app.keyWindow setWindowLevel:UIWindowLevelStatusBar];
    
    //自定义view加到顶部
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    view.backgroundColor = [UIColor clearColor];
    [app.keyWindow addSubview:view];
    
    //加上label
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(220, 0, 100, 20);
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:10];
    label.text = @"这个是自定义状态栏";
    [view addSubview:label];
    
    //测试效果
    ViewController *page = [[ViewController alloc]init];
    [self.navigationController pushViewController:page animated:YES];

//    ////下面代码是把状态栏再显示出来
//    [app.keyWindow setWindowLevel:UIWindowLevelNormal];
//    [view removeFromSuperview];
}
@end
