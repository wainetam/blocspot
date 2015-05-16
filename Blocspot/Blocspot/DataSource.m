//
//  DataSource.m
//  Blocspot
//
//  Created by Waine Tam on 4/6/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "DataSource.h"
#import "POI.h"

@implementation DataSource

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.favorites = [NSMutableArray new];
        self.categories = [NSMutableDictionary dictionaryWithDictionary:@{
            @"restaurant" : [NSMutableArray new],
            @"bar" : [NSMutableArray new],
            @"store" : [NSMutableArray new],
            @"museum" : [NSMutableArray new],
        }];
    }
    
    return self;
}

@end
