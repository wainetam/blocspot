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
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *fullPath = [self pathForFilename:NSStringFromSelector(@selector(favorites))];
            NSArray *storedFavorites = [NSKeyedUnarchiver unarchiveObjectWithFile:fullPath];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (storedFavorites.count > 0) { // if there are cachedItems
                    NSMutableArray *mutableMediaItems = [storedFavorites mutableCopy];
                    
                    [self.favorites removeAllObjects];
                    [self.favorites addObjectsFromArray:storedFavorites];
//                    self.favorites = mutableMediaItems;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedFavoritesNotification" object: [DataSource sharedInstance].favorites];
                    
                    // refresh app if there is cached content already; user will not have to pull-to-refresh when app launched
                    
                }
            });
            
        });
    }
    
    return self;
}

#pragma mark - Archiving
- (NSString *) pathForFilename:(NSString *) filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:filename];
    return dataPath;
}

- (void) saveToDisk{
    
    // write the changes to disk
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSUInteger numberOfItemsToSave = MIN(self.favorites.count, 50);
        NSArray *favoritesToSave = [self.favorites subarrayWithRange:NSMakeRange(0, numberOfItemsToSave)];
        
        NSString *fullPath = [self pathForFilename:NSStringFromSelector(@selector(favorites))];
        NSData *favoriteItemData = [NSKeyedArchiver archivedDataWithRootObject:favoritesToSave];
        
        NSError *dataError;
        BOOL wroteSuccessfully = [favoriteItemData writeToFile:fullPath options:NSDataWritingAtomic | NSDataWritingFileProtectionCompleteUnlessOpen error:&dataError];
        
        if (!wroteSuccessfully) {
            NSLog(@"Couldn't write file: %@", dataError);
        }
    });
    
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
