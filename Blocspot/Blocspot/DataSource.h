//
//  DataSource.h
//  Blocspot
//
//  Created by Waine Tam on 4/6/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import <UICKeyChainStore/UICKeyChainStore.h>

@class POI;
@class Search;
@class BSCategory;

@interface DataSource : NSObject

+ (instancetype) sharedInstance;

@property (nonatomic, strong) NSMutableArray *searchHistory;
@property (nonatomic, strong) NSArray *poiResults;
@property (nonatomic, strong) NSArray *annotations; // QUESTION: should I store annotations here or with mapView?
@property (nonatomic, strong) NSMutableDictionary *categories;
@property (nonatomic, strong) NSMutableArray *favorites;

- (void)cancelActiveSearch:(Search *)search;
- (void)deleteSearchHistory:(NSMutableArray *)searchHistory;
- (void)requestSearchHistory;
- (void)addCategory:(BSCategory *)category;
- (void)clearFavorites;


//- (void)requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler;



@end
