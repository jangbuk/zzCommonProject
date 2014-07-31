//
//  AppDelegate.m
//  zzProject
//
//  Created by zz on 14-7-31.
//  Copyright (c) 2014年 YunFeng. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

#import "MobClick.h"
#define UMENG_APPKEY @"53c799e056240bcfc******"//umeng_key

zzData *g_data;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    g_data = [[zzData alloc]init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //开启umeng自动更新
    [self OpenUMeng];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)OpenUMeng //打开友盟
{
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
}

- (void)updateMethod:(NSDictionary *)appInfo {
    NSLog(@"update info %@",appInfo);
    if([[appInfo objectForKey:@"update"] isEqualToString:@"YES"]==YES)
    {
        NSString *newVersion = [[NSString alloc]initWithString:[appInfo objectForKey:@"version"]];
        newVersionPath = [[NSString alloc]initWithString:[appInfo objectForKey:@"path"]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"有新版本V%@",newVersion] message:[NSString stringWithString:[appInfo objectForKey:@"update_log"]] delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles:@"更新", nil];
        alert.tag = 11;
        [alert show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag==11&&buttonIndex==1)
    {
        NSURL *url = [NSURL URLWithString:newVersionPath];  [[UIApplication sharedApplication]openURL:url];
    }
}

@end
