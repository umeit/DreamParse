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
    NSMutableSet *randomSet = [[NSMutableSet alloc] init];
    
    NSMutableArray *randomList = [[NSMutableArray alloc] init];
    
    NSInteger randomS = 34;
    NSInteger random;
    
//    while ([randomList count] < listCount) {
//        random = (arc4random() % randomS) + 1;
//        [randomList addObject:@(random)];
//        randomS += 34;
//    }
    
    while ([randomSet count] < listCount) {
        random = (arc4random() % 1700) + 1;
        [randomSet addObject:@(random)];
    }
    
    return [randomSet allObjects];
}

@end
