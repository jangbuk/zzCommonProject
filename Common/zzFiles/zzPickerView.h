//
//  SelectBankAddress.h
//  rry
//
//  Created by zz on 14-6-20.
//  Copyright (c) 2014年 yunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol zzPickerViewDelegate <NSObject>

-(void)SelectIndex:(int)tag  selectIndex:(int)selectIndex;

@end


@interface zzPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate,zzPickerViewDelegate>
{
    int selectRow;
}

-(void)initPickView;

@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIPickerView *pickView;

@property (retain,nonatomic) id delegate;

@end
