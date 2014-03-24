//
//  DPAppDelegate.m
//  DreamParse
//
//  Created by Liu Feng on 14-2-23.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import "DPAppDelegate.h"
#import "MobClick.h"
#import "RFRateMe.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

@implementation DPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *umAppKey = @"5321d22a56240b031d03dc4d";
    
    [MobClick startWithAppkey:umAppKey reportPolicy:SEND_ON_EXIT channelId:nil];
    
    [RFRateMe showRateAlertAfterTimesOpened:3];
    
    [UMSocialData setAppKey:umAppKey];
    [UMSocialData openLog:YES];
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [UMSocialWechatHandler setWXAppId:@"wxcc116774ec0a07e8" url:nil];
    [UMSocialData defaultData].extConfig.title = @"标题";
    // 点击跳转地址
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://www.baidu.com";
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://www.baidu.com";
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

@end
