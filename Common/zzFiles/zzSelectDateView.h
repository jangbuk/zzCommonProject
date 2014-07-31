//
//  zzSelectDateView2.h
//  MFMClient
//
//  Created by zzzili on 14-3-4.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol zzSelectDateDelegate <NSObject>

-(void)GetSelectTime:(id)sender date:(NSDate*)date;

@end

@interface zzSelectDateView : UIView<zzSelectDateDelegate>

@property (strong,nonatomic) UIDatePicker *datePicker;

@property (retain, nonatomic) id delegate;

-(void)setDefaultTime:(NSDate *)defaultTime;

@end
