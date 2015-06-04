//
//  POI.m
//  Blocspot
//
//  Created by Waine Tam on 4/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "POI.h"
#import "DataSource.h"
#import "BSCategory.h"

//NSString *const EditedFavoritesNotification = @"EditedFavoritesNotification";

@implementation POI

#pragma mark - NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        self.name = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(name))];
        self.category = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(category))];
        self.visited = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(visited))];
        self.addressDict = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(addressDict))];
        self.phoneNumber = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(phoneNumber))];
        self.url = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(url))];
        self.location = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(location))];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:NSStringFromSelector(@selector(name))];
    [aCoder encodeObject:self.category forKey:NSStringFromSelector(@selector(category))];
    [aCoder encodeBool:self.visited forKey:NSStringFromSelector(@selector(visited))];
    [aCoder encodeObject:self.addressDict forKey:NSStringFromSelector(@selector(addressDict))];
    [aCoder encodeObject:self.phoneNumber forKey:NSStringFromSelector(@selector(phoneNumber))];
    [aCoder encodeObject:self.url forKey:NSStringFromSelector(@selector(url))];
    [aCoder encodeObject:self.location forKey:NSStringFromSelector(@selector(location))];
    
}

//@property (nonatomic, strong) NSString *name;
//@property (nonatomic, assign) float distanceTo;
//@property (nonatomic, strong) NSString *note;
//@property (nonatomic, strong) BSCategory *category;
//@property (nonatomic, assign) bool visited;
//@property (nonatomic, strong) NSDictionary *addressDict;
//@property (nonatomic, strong) NSString *phoneNumber;
//@property (nonatomic, strong) NSString *url;
//@property (nonatomic, strong) CLLocation *location;

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

- (bool) isFavorited {
    return [[DataSource sharedInstance].favorites containsObject:self];
}

- (bool) hasCategory:(BSCategory *)category {
    return [[DataSource sharedInstance].categories[category.name] containsObject:self];
}

- (void) addToFavorites {
    if (![self isFavorited]) {
        [[DataSource sharedInstance].favorites addObject:self];
        // QUESTION: how to create constants
        [[DataSource sharedInstance] saveToDisk];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedFavoritesNotification" object:[DataSource sharedInstance].favorites];
    } else {
        // manage this case
        NSLog(@"already added to favorites list");
    }
}

- (void) removeFromFavorites {
    if ([self isFavorited]) {
        [[DataSource sharedInstance].favorites removeObject:self];
        [[DataSource sharedInstance] saveToDisk];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedFavoritesNotification" object:[DataSource sharedInstance].favorites];
    }
}

- (void) removeFromCategory:(BSCategory *)category {
    if ([self hasCategory:category]) {
        [[DataSource sharedInstance].categories[category.name] removeObject:self];
        
    }
}

- (void) assignToCategory:(BSCategory *)category {
    if (![self hasCategory:category]) { // no category assigned to poi
        if ([DataSource sharedInstance].categories[category.name]) {
            [[DataSource sharedInstance].categories[category.name] addObject:self];
            self.category = category; // add category to POI itself
            
            // add to Favorites if haven't already

            if (![self isFavorited]) {
                [self addToFavorites];
            }
        } else {
            NSLog(@"No such category exists");
        }
        
    } else { // already added to category X and changing categories
        BSCategory *origCategory = self.category;
        [[DataSource sharedInstance].categories[origCategory.name] removeObject:self];
        self.category = category;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedFavoritesNotification" object:[DataSource sharedInstance].favorites];
}



@end
