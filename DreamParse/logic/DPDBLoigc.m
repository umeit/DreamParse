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
    
    NSMutableArray *dreameEntiryArrary = [[NSMutableArray alloc] init];
    
    while ([s next]) {
        [dreameEntiryArrary addObject:[self dreamEntityWithFMResult:s]];
    }
    
    return dreameEntiryArrary;
}

+ (DPDreamEntity *)searchDreamWithKeyWord:(NSString *)keyWord
{
    FMDatabase *db = [FMDatabase databaseWithPath:DBPath];
    if (![db open]) {
        return nil;
    }
    
    NSString *SQL = [NSString stringWithFormat:@"SELECT * FROM zgjm WHERE title LIKE '%%%@%%'", keyWord];
    
    FMResultSet *s = [db executeQuery:SQL];
    
    DPDreamEntity *dreamEntity;
    if ([s next]) {
        dreamEntity = [self dreamEntityWithFMResult:s];
    }
    
    return dreamEntity;
}


#pragma - mark Private

+ (DPDreamEntity *)dreamEntityWithFMResult:(FMResultSet *)s
{
    DPDreamEntity *dreamEntity = [[DPDreamEntity alloc] init];
//    dreamEntity.dbID = [s intForColumnIndex:0];
    dreamEntity.category = [s intForColumnIndex:0];
    dreamEntity.key = [s stringForColumnIndex:1];
    dreamEntity.bodyText = [s stringForColumnIndex:2];
    
    return dreamEntity;
}

+ (NSString *)dbPath
{
    static NSString *dbPath;
    dbPath = [[NSBundle mainBundle] pathForResource:@"DP" ofType:@"db"];
    
    return dbPath;
}

@end
