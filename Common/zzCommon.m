//
//  zzCommon.m
//  XingKeHui
//
//  Created by zzzili on 13-3-6.
//  Copyright (c) 2013年 zzzili. All rights reserved.
//

#import "zzCommon.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "JSONKit.h"

@implementation zzCommon

-(NSDictionary*)GetDictionaryWithJson:(NSString*)jsonStr
{
    return [jsonStr objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
}

-(NSArray*)GetArrayWithJson:(NSString*)jsonStr
{
    return [jsonStr objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
}

-(NSString *)GetReturnFromPost:(NSString*)urlStr  postData:(NSString*)_postData
{
    if(_postData==nil)
        _postData = @"";
    NSData *postData = [_postData dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setTimeoutInterval:15];
    [request setURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    //同步请求的的代码
    //returnData就是返回得到的数据
    NSData *returnData =[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [[NSString alloc]initWithData:returnData encoding:NSUTF8StringEncoding];
}

-(NSString *)GetReturnFromGET:(NSString*)urlStr
{
    return [NSString stringWithContentsOfURL:[NSURL URLWithString:urlStr] encoding:NSUTF8StringEncoding error:nil];
}



+(UIImage*)GetLashenImage:(NSString*)imageName size:(CGRect)_size
{
    return [[UIImage imageNamed:imageName]
            resizableImageWithCapInsets:UIEdgeInsetsMake(_size.origin.x,_size.origin.y,_size.size.width,_size.size.height)];
}

+(void)SetViewBorder:(UIView*)view
{
    //    view.layer.borderWidth=1.0;
    //    view.layer.borderColor=[[UIColor grayColor] CGColor];
    
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    
    view.layer.borderWidth =1.0;
    
    view.layer.cornerRadius =5.0;
}

+(NSString*)Date2String:(NSDate*)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyy-MM-dd"];// HH:mm:ss
    return [formatter stringFromDate:date];
}

+(NSDate*)String2Date:(NSString*)dateStr formatStr:(NSString*)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : formatStr];// HH:mm:ss
    return [formatter dateFromString:dateStr];
}

+(NSString*)GetWeek:(NSDate*)date
{
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = [componets weekday];
    switch (weekday) {
        case 1:
            return @"日";
            break;
        case 2:
            return @"一";
            break;
        case 3:
            return @"二";
            break;
        case 4:
            return @"三";
            break;
        case 5:
            return @"四";
            break;
        case 6:
            return @"五";
            break;
        case 7:
            return @"六";
            break;
            
        default:
            return @"";
            break;
    }
}

+(int)GetDayNumOf2Date:(NSDate*)startDay endDay:(NSDate*)endDay
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlag = NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlag fromDate:startDay toDate:endDay options:0];
    int num = [components day]+1;
    return num;
    
}
+(CGSize)GetStringSize:(NSString *)str  font:(UIFont*)_font  ConWidth:(int)_width
{
    CGSize size = [str sizeWithFont:_font constrainedToSize:CGSizeMake(_width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    size.height = size.height + 36.0;
    
    return size;
}
+(void)zzLog:(NSString*)str
{
    
	static NSString *filePath;
    if(filePath == nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        filePath = [documentsDirectory stringByAppendingPathComponent:@"zzlog.log"];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    
    
    NSString *fileStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    fileStr = [NSString stringWithFormat:@"%@\r\n%@:%@",fileStr,destDateString,str];
    [fileStr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
+(void)zzDelLog
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"zzlog.log"];
    NSFileManager *fileMan = [NSFileManager defaultManager];
    [fileMan removeItemAtPath:filePath error:nil];
}

+(NSString*)GetCacheDicPath:(NSString*)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSLog(filePath);
    return filePath;
}
@end
