//
//  POI.m
//  Blocspot
//
//  Created by Waine Tam on 4/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "POI.h"

@implementation POI

- (instancetype) initWithDictionary:(NSDictionary *)poiDict {
    self.name = poiDict[@"name"];
//    self.distanceTo = poiDict[@"distanceTo"];
    self.note = poiDict[@"note"];
    self.category = poiDict[@"category"];
//    self.visited = poiDict[@"visited"];
    self.addressDict = poiDict[@"addressDict"];
    self.phoneNumber = poiDict[@"phoneNumber"];
    self.url = poiDict[@"url"];

    return self;
}

@end