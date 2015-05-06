//
//  Annotation.h
//  Blocspot
//
//  Created by Waine Tam on 5/6/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <MapKit/MapKit.h>

//@interface Annotation : MKPointAnnotation
@interface Annotation : MKPointAnnotation {
//    CLLocationCoordinate2D coordinate; // QUESTION what is this syntax?
}


//@property (nonatomic) CLLocationCoordinate2D coordinate;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;
- (id)initWithPlacemark:(MKPlacemark *)placemark;
- (id)initWithMapItem:(MKMapItem *)mapItem;

@end
