//
//  Search.h
//  Blocspot
//
//  Created by Waine Tam on 4/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class Search;

@protocol SearchDelegate <NSObject>

- (void) didCompleteSearch:(Search *)sender;

@end

//@interface Search : MKLocalSearch
@interface Search : NSObject

@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic) CLLocationCoordinate2D userLocation;
@property (nonatomic, strong) NSMutableArray *poiResults;
@property (nonatomic) MKCoordinateRegion boundingRegion;
@property (nonatomic, strong) id<SearchDelegate> delegate;

- (void)executeSearch:(NSString *)searchString;
- (NSDictionary *)parseMapItemProperties:(MKMapItem *)mapItem;

@end
