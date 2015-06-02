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
        self.lastFavoriteLocalNotifications = [NSMutableArray new];
    }
    
    return self;
}

- (void)sortResults:(NSArray *)results byCategory:(BSCategory *)category completion:(void(^)(void))completion {
    NSMutableArray *sortedResults = [[NSMutableArray alloc] init];
    for (POI* poi in results) {
        if (poi.category.name == category.name) {
            [sortedResults addObject:poi];
        }
    }
    self.sortedResults = [sortedResults copy];
    self.favoritesSortedByCategory = YES;
    
    completion();
}

- (void)revertSortedResults:(NSArray *)sortedResults {
    self.sortedResults = @[];
    self.favoritesSortedByCategory = NO;
}

- (bool)favorite:(POI *)favorite isInLastFavoriteLocalNotificationArray:(int)count {
    
    NSRange range = NSMakeRange(0,0);
    NSArray *lastFavoriteNotificationsArrayByCount = nil;
    
    if (self.lastFavoriteLocalNotifications) {
        range = NSMakeRange(0, MIN([self.lastFavoriteLocalNotifications count], count));
        lastFavoriteNotificationsArrayByCount = [self.lastFavoriteLocalNotifications subarrayWithRange:range];
    }
    
    
    return lastFavoriteNotificationsArrayByCount != nil && [lastFavoriteNotificationsArrayByCount containsObject:favorite];
}

@end
