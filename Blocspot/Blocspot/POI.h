//
//  POI.h
//  Blocspot
//
//  Created by Waine Tam on 4/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POI : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) float distanceTo;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, assign) bool visited;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *website;

- (void)poi:(POI *)poi comment:(NSString *)comment; // poi:comment:


@end
