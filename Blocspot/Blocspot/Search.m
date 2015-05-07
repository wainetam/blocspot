//
//  Search.m
//  Blocspot
//
//  Created by Waine Tam on 4/7/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "Search.h"
#import "DataSource.h"
#import "POI.h"
#import "Annotation.h"

@interface Search ()

@end

@implementation Search

- (id) init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (void)executeSearch:(NSString *)searchString withMapView:(MKMapView *)mapView
{
    if (self.localSearch.searching)
    {
        [self.localSearch cancel];
    }
    
    // confine the map search area to the user's current location
    MKCoordinateRegion currentRegion;
    currentRegion.center.latitude = self.userLocation.latitude;
    currentRegion.center.longitude = self.userLocation.longitude;
    
    // setup the area spanned by the map region:
    // we use the delta values to indicate the desired zoom level of the map,
    //      (smaller delta values corresponding to a higher zoom level)
    //
    currentRegion.span.latitudeDelta = 0.9;
    currentRegion.span.longitudeDelta = 0.9;
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    
    request.naturalLanguageQuery = searchString;
    request.region = currentRegion;
    
    MKLocalSearchCompletionHandler completionHandler = ^(MKLocalSearchResponse *response, NSError *error)
    {
        if (error != nil)
        {
            NSString *errorStr = [[error userInfo] valueForKey:NSLocalizedDescriptionKey];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not find places"
                                                            message:errorStr
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            NSArray *responseItems = [response mapItems];
//            NSMutableArray *placemarks = [NSMutableArray new];
            NSMutableArray *annotations = [NSMutableArray new];
            self.poiResults = [[NSMutableArray alloc] init];
            
            for (MKMapItem *mapItem in responseItems) {
//                if (MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(mapItem.placemark.coordinate))) {
//                    [placemarks addObject:mapItem.placemark];
//                }
//                [placemarks addObject:mapItem.placemark];
                Annotation *annotation = [[Annotation alloc] initWithMapItem:mapItem];
//                Annotation *annotation = [[Annotation alloc] initWithLocation:mapItem.placemark.location.coordinate];
//                annotation.title = mapItem.name;
                
                [annotations addObject:annotation];
                NSDictionary *mapItemDict = [self parseMapItemProperties:mapItem];
                POI *poi = [[POI alloc] initWithDictionary:mapItemDict];
                [self.poiResults addObject:poi];
            }
            
            [DataSource sharedInstance].poiResults = self.poiResults; // fix
            
            
            // add annotations
            [DataSource sharedInstance].annotations = nil;
            [mapView removeAnnotations:[mapView annotations]];
            
            
//            MKMapRect visibleMapRect = mapView.visibleMapRect;
//            NSArray *visibleAnnotations = [[mapView annotationsInMapRect:visibleMapRect] allObjects]; // convert NSSet to NSArray
            
            [mapView showAnnotations:annotations animated:YES];
            [DataSource sharedInstance].annotations = annotations;
            // used for later when setting the map's region in "prepareForSegue"
            self.boundingRegion = response.boundingRegion;
            
            // callback to tabBar
//            [self.delegate didCompleteSearch:self];
            
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    };
    
    if (self.localSearch != nil)
    {
        self.localSearch = nil;
    }
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [self.localSearch startWithCompletionHandler:completionHandler];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (NSDictionary *)parseMapItemProperties:(MKMapItem *)mapItem {
    NSString *name = (NSString *)mapItem.name != nil ? (NSString *)mapItem.name : @"";
    NSString *url = (NSString *)mapItem.url != nil ? (NSString *)mapItem.url : @"";
    
    NSString *phoneNumber = (NSString *)mapItem.phoneNumber != nil ? (NSString *)mapItem.phoneNumber : @"";
    CLLocation *location = (CLLocation *)mapItem.placemark.location != nil ? (CLLocation *)mapItem.placemark.location : [CLLocation new];
    NSDictionary *addressDict = (NSDictionary *)mapItem.placemark.addressDictionary != nil ? mapItem.placemark.addressDictionary : [NSDictionary new];
    
    NSArray *mapItemValues = @[name, url, phoneNumber, location, addressDict];
    
    NSArray *mapItemKeys = @[@"name", @"url", @"phoneNumber", @"location", @"addressDict"];
    
    return [[NSDictionary alloc] initWithObjects:mapItemValues forKeys:mapItemKeys];
}


@end
