//
//  FavoritesTableViewController.m
//  Blocspot
//
//  Created by Waine Tam on 5/15/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "DataSource.h"

@interface FavoritesTableViewController ()

@end

@implementation FavoritesTableViewController

- (id)init {
    if (self) {
        self = [super init];
        self.resultsKeyPath = @"poiFavorites";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableData:) name:@"EditedFavoritesNotification" object:[DataSource sharedInstance]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.results = [DataSource sharedInstance].favorites;
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
