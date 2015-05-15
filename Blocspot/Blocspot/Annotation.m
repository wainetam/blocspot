//
//  Annotation.m
//  Blocspot
//
//  Created by Waine Tam on 5/6/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation
//@synthesize coordinate;
// QUESTION: why need to do this?
//https://developer.apple.com/library/ios/documentation/UserExperience/
//Conceptual/LocationAwarenessPG/AnnotatingMaps/AnnotatingMaps.html#//apple_ref/doc/uid/TP40009497-CH6-SW2

- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        self.coordinate = coord;
    }
    return self;
}

- (id)initWithPlacemark:(MKPlacemark *)placemark {
    self = [self initWithLocation:placemark.location.coordinate];
    
    return self;
}

- (id)initWithMapItem:(MKMapItem *)mapItem {
    self = [self initWithPlacemark:mapItem.placemark];
    self.title = mapItem.name;
    self.subtitle = mapItem.placemark.subLocality; // or .thoroughfare ha
    
    return self;
}

//- (void)favorited:(id)sender {
//    NSLog(@"FAVORITED");
//}


@end
