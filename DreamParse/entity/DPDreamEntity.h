//
//  DPDreamEntity.h
//  DreamParse
//
//  Created by Liu Feng on 14-2-24.
//  Copyright (c) 2014年 Liu Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DPDreamEntity : NSObject

@property (nonatomic) NSInteger dbID;

@property (nonatomic) NSInteger category;

@property (nonatomic, strong) NSString *key;

@property (nonatomic, strong) NSString *bodyText;

@end
