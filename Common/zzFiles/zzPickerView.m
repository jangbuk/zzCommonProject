//
//  SelectBankAddress.m
//  rry
//
//  Created by zz on 14-6-20.
//  Copyright (c) 2014年 yunfeng. All rights reserved.
//

#import "zzPickerView.h"


@implementation zzPickerView

-(void)initPickView
{
    selectRow = 0;
    // Do any additional setup after loading the view from its nib.
    CGRect rx = [UIScreen mainScreen ].bounds;
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, rx.size.height-206, 320, 206)];
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    ////////toolBar
    UIToolbar *tool = [[UIToolbar alloc]init];
    tool.frame = CGRectMake(0, 0, 320, 44);
    [self.backView addSubview:tool];
    
    UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(touchCancel:)];
    UIBarButtonItem *itemLine = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *itemOk = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(touchOk:)];
    
    tool.items = [NSArray arrayWithObjects:itemCancel,itemLine,itemOk, nil];
    
    ////////picker
    self.pickView = [[UIPickerView alloc]init];
    self.pickView.frame = CGRectMake(0, 44, 320, 162);
    self.pickView.dataSource = self;
    self.pickView.delegate = self;
    [self.backView addSubview:self.pickView];
}
- (IBAction)touchCancel:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)touchOk:(id)sender {
    [self.delegate SelectIndex:self.tag selectIndex:selectRow];
    [self removeFromSuperview];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.dataList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        return [self.dataList objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectRow = row;
}

@end
