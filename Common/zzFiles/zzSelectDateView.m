//
//  zzSelectDateView2.m
//  MFMClient
//
//  Created by zzzili on 14-3-4.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import "zzSelectDateView.h"

@implementation zzSelectDateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        // Drawing code
        UIView *btnView = [[UIView alloc]init];
        btnView.backgroundColor = [UIColor whiteColor];
        if(iPhone5)
        {
            btnView.frame = CGRectMake(0, 274+88, 320, 206);
        }
        else
        {
            btnView.frame = CGRectMake(0, 274, 320, 206);
        }
        [self addSubview:btnView];
        
        ////////toolBar
        UIToolbar *tool = [[UIToolbar alloc]init];
        tool.frame = CGRectMake(0, 0, 320, 44);
        [btnView addSubview:tool];
        
        UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(touchCancel)];
        UIBarButtonItem *itemLine = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *itemOk = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(touchOK)];
        
        tool.items = [NSArray arrayWithObjects:itemCancel,itemLine,itemOk, nil];
        
        ////////picker
        self.datePicker = [[UIDatePicker alloc]init];
        self.datePicker.frame = CGRectMake(0, 44, 320, 162);
        self.datePicker.datePickerMode = UIDatePickerModeDate;
        [btnView addSubview:self.datePicker];
        
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
}

-(void)setDefaultTime:(NSDate *)defaultTime
{
    self.datePicker.date = defaultTime;
}
-(void)touchCancel
{
    [self removeFromSuperview];
}

-(void)touchOK
{
    [self.delegate GetSelectTime:self date:self.datePicker.date];
    [self removeFromSuperview];
}
@end
