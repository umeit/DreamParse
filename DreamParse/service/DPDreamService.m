//
//  DPDreamService.m
//  DreamParse
//
//  Created by Liu Feng on 14-2-24.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import "DPDreamService.h"
#import "DPDBLoigc.h"

@implementation DPDreamService

- (void)randomDreamList:(DPDreamServiceListBlock)block
{
    NSMutableArray *randomList = [[NSMutableArray alloc] init];
    
    NSInteger random = (arc4random() % 34) + 1;
    
    while ([randomList count] < 50) {
        [randomList addObject:@(random)];
        random += 34;
    }
    
    NSArray *dreamList = [DPDBLoigc dreamListWithDBIDs:randomList];
    
    block(dreamList);
}

@end
