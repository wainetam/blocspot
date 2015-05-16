//
//  ResultsTableViewController.m
//  Blocspot
//
//  Created by Waine Tam on 4/12/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "DataSource.h"

@interface ResultsTableViewController ()

@end

@implementation ResultsTableViewController

- (id)init {
    if (self) {
        self = [super init];
        self.resultsKeyPath = @"poiResults";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.results = [DataSource sharedInstance].poiResults;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)dealloc {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
