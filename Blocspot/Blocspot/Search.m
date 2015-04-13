//
//  Search.m
//  Blocspot
//
//  Created by Waine Tam on 4/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "Search.h"
#import "DataSource.h"

//QUESTION: do I create a search object? subclass?
@implementation Search

//- (instancetype) initWithRequest:(MKLocalSearchRequest *)request {
//    self = [super initWithRequest:request];
//
//    if (self) {
//        return self;
//    } else {
//        return nil;
//    }
//    
//}

- (instancetype) initWithQuery:(NSString *)query {
    return [self initWithQuery:query withMap:nil];
}

- (instancetype) initWithQuery:(NSString *)query withMap:(MKMapView *)mapView {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = query;
    
    if (mapView) {
        request.region = mapView.region;
    }
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    return (Search *)search;
}

- (void) executeSearch:(Search *)search {
//    QUESTION: what to do for a dissimilar/edited search? do lookup in search History
    // catch errors re: location permissions denied or offline connection
    if (search.searching) { // same search is searching
        [search cancel];
    }
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"Error occurred: %@", error);
        }
        
        NSLog(@"Map Items: %@", response.mapItems);
        
        //    QUESTION: best way to save search history? set up KVO for search history -- when that changes, we should update
        [[DataSource sharedInstance].searchHistory addObject:search];
    }];
}

// searching property (boolean)

//[search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
//    NSLog(@"Map Items: %@", response.mapItems);
//}];

//array of MKMapItem objects
//placemark property

@end
