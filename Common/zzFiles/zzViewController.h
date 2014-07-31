//
//  zzViewController.h
//  MFMClient
//
//  Created by zzzili on 14-2-16.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface zzViewController : UIViewController<MBProgressHUDDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    MBProgressHUD *HUD;
}

-(void)SetTopBarImg;

-(void)SetBtnBackImg:(UIButton*)btn;

-(void)SetBtnBackImg2:(UIButton*)btn;

-(UIButton*)zzCreateItemBtn;

-(void)ShowMsgInUIView:(NSString*)msg;

-(void)SetHUD;
-(void)SetHUDWithSel:(SEL)method;
@end
