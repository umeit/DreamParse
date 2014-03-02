//
//  DPDreamService.h
//  DreamParse
//
//  Created by Liu Feng on 14-2-24.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPDreamEntity;

typedef void(^DPDreamServiceListBlock)(NSArray *list);

@interface DPDreamService : NSObject

+ (instancetype)sharedInstance;

- (void)mainPageList:(DPDreamServiceListBlock)block;

@end
