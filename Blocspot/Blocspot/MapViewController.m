//
//  MapViewController.m
//  Blocspot
//
//  Created by Waine Tam on 4/12/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "MapViewController.h"
#import "POI.h"
#import "DataSource.h"
#import "User.h"
#import "Search.h"
#import "ResultsTableViewController.h"


@interface MapViewController ()

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) MKLocalSearch *localSearch;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocationCoordinate2D userLocation;
@property (nonatomic, strong) NSMutableArray *poiResults;
@property (nonatomic, strong) MKMapView *mapView;
@property (nonatomic) MKCoordinateRegion boundingRegion;
@property (nonatomic, strong) ResultsTableViewController *tableVC;

@end

@implementation MapViewController

- (void)loadView {
    [super loadView];
    
    self.tableVC = [[ResultsTableViewController alloc] init];
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
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLoc.coordinate, 750, 750);
    [mapView setRegion:region animated:YES];
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
//    CGFloat heightNavHeader = self.navigationController.navigationBar.frame.size.height;
    
    CGFloat heightSearchBar = 44;
    
    self.mapView.frame = CGRectMake(0, self.topLayoutGuide.length + heightSearchBar, width, height - self.topLayoutGuide.length - heightSearchBar);
    
    
    
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

- (void)startSearch:(NSString *)searchString
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
    currentRegion.span.latitudeDelta = 0.112872;
    currentRegion.span.longitudeDelta = 0.109863;
    
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
            self.poiResults = [[NSMutableArray alloc] init];
            
            for (MKMapItem *mapItem in responseItems) {
                NSDictionary *mapItemDict = [self parseMapItemProperties:mapItem];
                POI *poi = [[POI alloc] initWithDictionary:mapItemDict];
                [self.poiResults addObject:poi];
            }
            
            [DataSource sharedInstance].poiResults = self.poiResults; // fix
            
            [self.navigationController pushViewController:self.tableVC animated:YES];
//            [self presentViewController:self.tableVC animated:YES completion:^{
//                NSLog(@"table VC here");
//            }];
            
            // used for later when setting the map's region in "prepareForSegue"
            self.boundingRegion = response.boundingRegion;
            
//            self.viewAllButton.enabled = self.places != nil ? YES : NO;
            
//            [self.tableView reloadData];
            
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
        [self startSearch:searchBar.text];
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
//    MKCoordinateRegion newRegion = MKCoordinateRegionMakeWithDistance(self.userLocation, 750, 750);
//    [mapView setRegion:newRegion animated:YES];
//
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
