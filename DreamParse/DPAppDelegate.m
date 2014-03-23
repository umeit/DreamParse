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

@implementation DPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSString *umAppKey = @"5321d22a56240b031d03dc4d";
    
    [MobClick startWithAppkey:umAppKey reportPolicy:SEND_ON_EXIT channelId:nil];
    
    [RFRateMe showRateAlertAfterTimesOpened:3];
    
    [UMSocialData setAppKey:umAppKey];
    [UMSocialData openLog:YES];
    
    return YES;
}

@end
