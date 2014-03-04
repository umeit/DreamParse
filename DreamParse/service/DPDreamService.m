//
//  DPDreamService.m
//  DreamParse
//
//  Created by Liu Feng on 14-2-24.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import "DPDreamService.h"
#import "DPDBLoigc.h"
#import "DPDreamEntity.h"

@implementation DPDreamService

+ (instancetype)sharedInstance
{
    static DPDreamService *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DPDreamService alloc] init];
    });
    
    return instance;
}

- (void)mainPageList:(DPDreamServiceListBlock)block
{
    NSArray *randomNumberList = [self makeRandomNumberList:50];
    
    NSArray *dreamList = [DPDBLoigc dreamListWithDBIDs:randomNumberList];
    
    block(dreamList);
}

- (DPDreamEntity *)searchDreamWithKeyWord:(NSString *)keyWord
{
    DPDreamEntity *dreamEntity = [DPDBLoigc searchDreamWithKeyWord:keyWord];
    
    return dreamEntity;
}


#pragma mark - Private

// 返回一个随机数列表
- (NSArray *)makeRandomNumberList:(NSInteger)listCount
{
    NSMutableArray *randomList = [[NSMutableArray alloc] init];
    
    NSInteger random = (arc4random() % 34) + 1;
    
    while ([randomList count] < listCount) {
        [randomList addObject:@(random)];
        random += 34;
    }
    
    return randomList;
}

@end
