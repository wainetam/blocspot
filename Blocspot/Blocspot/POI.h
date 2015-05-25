//
//  POI.h
//  Blocspot
//
//  Created by Waine Tam on 4/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class BSCategory;

@interface POI : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) float distanceTo;
@property (nonatomic, strong) NSString *note;
@property (nonatomic, strong) BSCategory *category;
@property (nonatomic, assign) bool visited;
@property (nonatomic, strong) NSDictionary *addressDict;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) CLLocation *location;

- (void)poi:(POI *)poi comment:(NSString *)comment; // poi:comment:
- (instancetype) initWithDictionary:(NSDictionary *)poiDict;
- (bool) isFavorited;
- (bool) hasCategory:(BSCategory *)category;
- (void) addToFavorites;
- (void) removeFromFavorites;
- (void) assignToCategory:(BSCategory *)category;
- (void) removeFromCategory:(BSCategory *)category;

@end
