//
//  DPDBLoigc.h
//  DreamParse
//
//  Created by Liu Feng on 14-2-24.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DPDreamEntity;

@interface DPDBLoigc : NSObject

+ (DPDreamEntity *)dreamWithDBID:(NSInteger)dbID;

+ (NSArray *)likeKeyListWithKey:(NSString *)key;

+ (NSArray *)dreamListWithDBIDs:(NSArray *)idList;

@end
