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
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedFavoritesNotification" object:[DataSource sharedInstance].favorites];
    } else {
        // manage this case
        NSLog(@"already added to favorites list");
    }
}

- (void) removeFromFavorites {
    if ([self isFavorited]) {
        [[DataSource sharedInstance].favorites removeObject:self];
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
