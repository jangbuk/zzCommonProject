//
//  zzData.m
//  zzMJM
//
//  Created by zzzili on 14-2-11.
//  Copyright (c) 2014年 zzzili. All rights reserved.
//

#import "zzData.h"

#import "DataClass.h"
//#import "NSData+Base64.h"
#import <Foundation/NSData.h>



@implementation zzData

-(id)init
{
    self = [super init];
    if(self)
    {
        self.myMsg = [[MSG alloc]init];
    }
    return self;
}


@end
