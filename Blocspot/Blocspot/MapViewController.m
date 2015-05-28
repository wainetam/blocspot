//
//  MapViewController.m
//  Blocspot
//
//  Created by Waine Tam on 4/12/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "MapViewController.h"
#import "TabBarController.h"
#import "POI.h"
#import "DataSource.h"
#import "User.h"
#import "Search.h"
#import "ResultsTableViewController.h"
#import "Annotation.h"


//NSString *const EditedFavoritesNotification = @"EditedFavoritesNotification";

@interface MapViewController ()

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userLocation;
@property (nonatomic, strong) NSMutableArray *poiResults;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic) MKCoordinateRegion boundingRegion;
//@property (nonatomic, strong) ResultsTableViewController *tableVC;
@property (nonatomic, strong) id delegate; // may refactor later if subclass Search
@property (nonatomic, strong) id tableRowDelegate;

@end

@implementation MapViewController

- (void)loadView {
    [super loadView];
    
//    self.tableVC = [[ResultsTableViewController alloc] init];
    self.delegate = self.tabBarController;
    self.tableRowDelegate = (ResultsTableViewController *)self.tabBarController.viewControllers[1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // start by locating user's current position
    if (self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    
    self.locationManager.delegate = self;
    
    self.mapView = [[MKMapView alloc] init];

    self.mapView.delegate = self;
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    
    if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        self.mapView.showsUserLocation = YES;

    } else {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.view addSubview:self.mapView];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"Search for places";
    self.searchBar.delegate = self;

    [self.view addSubview:self.searchBar];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.parentViewController.title = @"Search";
//    self.parentViewController.navigationItem.title = @"Search";
    
    // adjust the map to zoom/center to the annotations we want to show
//    [self.mapView setRegion:self.boundingRegion];
    
    if (self.poiResults.count == 1)  // [DataSource sharedInstance].poiResults
    {
        MKMapItem *mapItem = [self.poiResults objectAtIndex:0];
        
        self.title = mapItem.name;
        
        // add the single annotation to our map
//        PlaceAnnotation *annotation = [[PlaceAnnotation alloc] init];
//        annotation.coordinate = mapItem.placemark.location.coordinate;
//        annotation.title = mapItem.name;
//        annotation.url = mapItem.url;
//        [self.mapView addAnnotation:annotation];
        
        // we have only one annotation, select it's callout
//        [self.mapView selectAnnotation:[self.mapView.annotations objectAtIndex:0] animated:YES];
        
        // center the region around this map item's coordinate
        self.mapView.centerCoordinate = mapItem.placemark.coordinate;
    }
    else
    {
        self.title = @"All Places";
        
        // add all the found annotations to the map
//        for (MKMapItem *item in self.mapItemList)
//        {
//            PlaceAnnotation *annotation = [[PlaceAnnotation alloc] init];
//            annotation.coordinate = item.placemark.location.coordinate;
//            annotation.title = item.name;
//            annotation.url = item.url;
//            [self.mapView addAnnotation:annotation];
//        }
    }
    // load saved annotations
    if ([DataSource sharedInstance].annotations != nil) {
        [self.mapView showAnnotations:[DataSource sharedInstance].annotations animated:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.mapView removeAnnotations:self.mapView.annotations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)zoomToCurrentLocation:(CLLocation *)currentLoc inMapView:(MKMapView *)mapView {
    if (!currentLoc) {
        return;
    }
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLoc.coordinate, 1000, 1000);
    [mapView setRegion:region animated:YES];
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds); // QUESTION: how to get height of tabBar
//    CGFloat heightNavHeader = self.navigationController.navigationBar.frame.size.height;
    
    CGFloat heightSearchBar = 44;
    
    self.mapView.frame = CGRectMake(0, self.topLayoutGuide.length + heightSearchBar, width, height - self.topLayoutGuide.length - heightSearchBar);
    NSLog(@"top layout guide length %f", self.topLayoutGuide.length);
    self.searchBar.frame = CGRectMake(0, self.topLayoutGuide.length, width, heightSearchBar);
}

#pragma mark - UISearchBarDelegate

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [searchBar resignFirstResponder];
    
    // check to see if Location Services is enabled, there are two state possibilities:
    // 1) disabled for entire device, 2) disabled just for this app
    //
    NSString *causeStr = nil;
    
    // check whether location services are enabled on the device
    if ([CLLocationManager locationServicesEnabled] == NO)
    {
        causeStr = @"device";
    }
    // check the application’s explicit authorization status:
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        causeStr = @"app";
    }
    else
    {
        // we are good to go, start the search
//        [self startSearch:searchBar.text];
        Search *search = [[Search alloc] init];
        search.delegate = (TabBarController *)self.tabBarController; //let tab controller control where results go
        [search executeSearch:searchBar.text withMapView:self.mapView];
    }
    
    if (causeStr != nil)
    {
        NSString *alertMessage = [NSString stringWithFormat:@"You currently have location services disabled for this %@. Please refer to \"Settings\" app to turn on Location Services.", causeStr];
        
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled"
                                                                        message:alertMessage
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // remember for later the user's current location
    
    self.userLocation = self.locationManager.location.coordinate;
    
    [self zoomToCurrentLocation:self.locationManager.location inMapView:self.mapView];
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;         // we might be called again here, even though we
    // called "stopUpdatingLocation", remove us as the delegate to be sure
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    // report any errors returned back from Location Services
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
        self.mapView.showsUserLocation = YES;
    }
}

#pragma mark - MKMapViewDelegate methods
//- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    self.userLocation = userLocation.location.coordinate;
//    [self zoomToCurrentLocation:self.locationManager.location inMapView:self.mapView];
//    [self.locationManager stopUpdatingLocation];
//    self.locationManager.delegate = nil;         // we might be called again here, even though we
        // called "stopUpdatingLocation", remove us as the delegate to be sure
//    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(self.userLocation, 750, 750);
//    [mapView setRegion:newRegion animated:YES];
//}

//- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLoc.coordinate, 1000, 1000);
//    [mapView setRegion:region animated:YES];
//    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(self.userLocation, 750, 750);
//    [mapView setRegion:newRegion animated:YES];

//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil; // to get default view for userLocation
    }
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[Annotation class]]) {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView* pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotationView"];
        
//        [[NSNotificationCenter defaultCenter] addObserver:annotation selector:@selector(favorited:) name:FavoritedNotification object:nil];
//                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didLoginWithEmail:) name:BENNET_TRY_LOGGING_IN_AS_USER object:nil];
//            
//        }];
        UIImage* heartImage = [UIImage imageNamed:@"heart-unfilled-24.png"];
        UIImage* heartImageFilled = [UIImage imageNamed:@"heart-filled-24.png"];
        
        if (!pinView) {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"CustomAnnotationView"];
            pinView.pinColor = MKPinAnnotationColorRed;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            
            // customize callout
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            [rightButton addTarget:self action:@selector(rightButtonCalloutHandler:) forControlEvents:UIControlEventTouchUpInside];
            pinView.rightCalloutAccessoryView = rightButton;
            
            // QUESTION: easiest way to keep track of changing icons and state?
            // Add a custom image to the left side of the callout.
//            UIImage* heartImage = [UIImage imageNamed:@"heart-unfilled-24.png"];
            
            UIButton *heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
            heartButton.frame = CGRectMake(0, 0, 40, 40);
            [heartButton setImage:heartImage forState:UIControlStateNormal];
            [heartButton setImage:heartImageFilled forState:UIControlStateSelected];

//            UIImageView *calloutImage = [[UIImageView alloc] initWithImage:heartImage];
            // how to add target to image (if want to make it a button)
            pinView.leftCalloutAccessoryView = heartButton;
            
        } else {
            pinView.annotation = annotation;
        }
        
        
        if ([self getPOIofAnnotation:annotation].isFavorited) {
            [(MKAnnotationView *)pinView.leftCalloutAccessoryView setSelected:YES];
        } else {
            [(MKAnnotationView *)pinView.leftCalloutAccessoryView setSelected:NO];
        }
        
        return pinView;
    }
    
    return nil;
}
//- (void)rightButtonCalloutHandler:(id)sender {
//    NSLog(@"hello from moreInfo");
//}

// QUESTION: do i need this? when do i use NSNotificationCenter?
- (POI *)getPOIofAnnotation:(Annotation *)annotation {
    NSUInteger annotationIndex = [[DataSource sharedInstance].annotations indexOfObject:annotation];
    return [[DataSource sharedInstance].poiResults objectAtIndex:annotationIndex];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    POI *poiAtIndex = [self getPOIofAnnotation:view.annotation];
    NSUInteger annotationIndex = [[DataSource sharedInstance].annotations indexOfObject:view.annotation];
    if ([view.leftCalloutAccessoryView isEqual:control]) {
//        POI *poiAtIndex = [self getPOIofAnnotation:view.annotation];
        if (control.selected) {
            [control setSelected:NO];
            [poiAtIndex removeFromFavorites];
        } else {
            [control setSelected:YES];
            [poiAtIndex addToFavorites];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedFavoritesNotification" object:[DataSource sharedInstance].favorites];
        
        NSLog(@"left button");
        // add to favorites
        
    }
    else if ([view.rightCalloutAccessoryView isEqual:control]){
        NSLog(@"right button");
        ((TabBarController *)self.delegate).selectedIndex = 1;
        [self.tableRowDelegate redirectToTableRow:(int)annotationIndex];
        
//        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:poiAtIndex inSection:1] animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
