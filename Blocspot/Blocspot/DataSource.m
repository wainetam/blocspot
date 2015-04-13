//
//  DataSource.m
//  Blocspot
//
//  Created by Waine Tam on 4/6/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
