//
//  InsetsTextField.h
//  sss
//
//  Created by HeHe on 14-5-20.
//  Copyright (c) 2014年 IOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zzInsetsTextField : UITextField
- (CGRect)textRectForBounds:(CGRect)bounds;
- (CGRect)editingRectForBounds:(CGRect)bounds;
@end
