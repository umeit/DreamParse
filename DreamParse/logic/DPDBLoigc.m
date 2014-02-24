//
//  DPDBLoigc.m
//  DreamParse
//
//  Created by Liu Feng on 14-2-24.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import "DPDBLoigc.h"
#import "DPDreamEntity.h"
#import "FMDatabase.h"

#define DBPath [self dbPath]

@implementation DPDBLoigc

+ (DPDreamEntity *)dreamWithDBID:(NSInteger)dbID
{
    return nil;
}

+ (NSArray *)likeKeyListWithKey:(NSString *)key
{
    return nil;
}

+ (NSArray *)dreamListWithDBIDs:(NSArray *)idList
{
    FMDatabase *db = [FMDatabase databaseWithPath:DBPath];
    if (![db open]) {
        return nil;
    }
    
    NSMutableString *whereString = [[NSMutableString alloc] init];
    
    for (NSNumber *n in idList) {
        [whereString appendFormat:@"rowid = %@ or ", n];
    }
    
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM zgjm WHERE %@",
                     [whereString substringToIndex:[whereString length] - 4]];
    FMResultSet *s = [db executeQuery:SQL];
    while ([s next]) {
        
        
        
    }
    
    return nil;
}


#pragma - mark Private

+ (NSString *)dbPath
{
    static NSString *dbPath;
    dbPath = [[NSBundle mainBundle] pathForResource:@"DP" ofType:@"db"];
    
    return dbPath;
}

@end
