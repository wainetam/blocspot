//
//  MapViewController.h
//  Blocspot
//
//  Created by Waine Tam on 4/12/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol TableViewRowDelegate <NSObject>

- (void) redirectToTableRow:(int)sender;

@end

@interface MapViewController : UIViewController <UISearchBarDelegate, CLLocationManagerDelegate, MKMapViewDelegate>

@end
