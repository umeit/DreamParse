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
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"

@implementation DPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [MobClick startWithAppkey:@"5321d22a56240b031d03dc4d" reportPolicy:SEND_ON_EXIT channelId:nil];
    
    [RFRateMe showRateAlertAfterTimesOpened:3];
    
    [ShareSDK registerApp:@"167c5c2cac92"];
    [ShareSDK connectWeChatFavWithAppId:@"1234" wechatCls:[WXApi class]];
    return YES;
}

@end
