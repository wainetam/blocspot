//
//  BSCategoryViewController.m
//  Blocspot
//
//  Created by Waine Tam on 5/17/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSCategory.h"
#import "BSCategoryButton.h"
#import "BSCategoryViewController.h"
#import "DataSource.h"
#import "ResultViewController.h"
#import "POI.h"

@interface BSCategoryViewController ()

@end

@implementation BSCategoryViewController

- (id)init {
    self = [super init];
    
    if (self) {
        self.categories = (NSMutableArray *)[[DataSource sharedInstance].categories allKeys];
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSArray *categoryButtons = [self createButtonsWithCategories:<#(NSArray *)#> withColors:<#(NSArray *)#> withResult:<#(id)#>]

    // create restaurant button
    BSCategory *restaurant = [[BSCategory alloc] initWithName:@"restaurant" withColor:[UIColor yellowColor]];
    
    self.assignToRestaurantButton = [[BSCategoryButton alloc] initWithCategory:restaurant withPOI:self.poiResult withTextColor:[UIColor yellowColor]];
    
    [self.assignToRestaurantButton setTitle:restaurant.name forState:UIControlStateNormal];
    
    [self.assignToRestaurantButton addTarget:self action:@selector(categoryButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    // create bar button
    BSCategory *bar = [[BSCategory alloc] initWithName:@"bar" withColor:[UIColor blueColor]];
    
    self.assignToBarButton = [[BSCategoryButton alloc] initWithCategory:bar withPOI:self.poiResult withTextColor:[UIColor blueColor]];
    
    [self.assignToBarButton setTitle:bar.name forState:UIControlStateNormal];
    
    [self.assignToBarButton addTarget:self action:@selector(categoryButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    // create museum button
    BSCategory *museum = [[BSCategory alloc] initWithName:@"museum" withColor:[UIColor redColor]];
    
    self.assignToMuseumButton = [[BSCategoryButton alloc] initWithCategory:museum withPOI:self.poiResult withTextColor:[UIColor redColor]];
    
    [self.assignToMuseumButton setTitle:museum.name forState:UIControlStateNormal];
    
    [self.assignToMuseumButton addTarget:self action:@selector(categoryButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    // create store button
    BSCategory *store = [[BSCategory alloc] initWithName:@"store" withColor:[UIColor greenColor]];
    
    self.assignToStoreButton = [[BSCategoryButton alloc] initWithCategory:store withPOI:self.poiResult withTextColor:[UIColor greenColor]];
    
    [self.assignToStoreButton setTitle:store.name forState:UIControlStateNormal];
    
    [self.assignToStoreButton addTarget:self action:@selector(categoryButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}

- (void) addViewsToView {
    NSMutableArray *views = [@[self.assignToRestaurantButton, self.assignToBarButton, self.assignToMuseumButton, self.assignToStoreButton] mutableCopy];
    for (UIView *view in views) {
        
//        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:view];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat viewWidth = [[UIScreen mainScreen] bounds].size.width;
//    CGFloat viewHeight = [[UIScreen mainScreen] bounds].size.height;
//    self.view.frame = CGRectMake(0, 0, viewWidth, viewHeight);
//    self.view.bounds = [[UIScreen mainScreen] bounds];
    
    CGFloat viewWidthCenter = viewWidth / 2.0;
    CGFloat buttonWidth = [BSCategoryButton width];
    CGFloat buttonPadding = [BSCategoryButton padding];
    CGFloat buttonHeight = [BSCategoryButton height];
    CGFloat topButtonMaxY = 150.0;
    
    self.assignToRestaurantButton.frame = CGRectMake(viewWidthCenter - buttonWidth/2, topButtonMaxY, buttonWidth, buttonHeight);
    self.assignToBarButton.frame = CGRectMake(viewWidthCenter - buttonWidth/2, CGRectGetMaxY(self.assignToRestaurantButton.frame) + buttonPadding, buttonWidth, buttonHeight);
    self.assignToMuseumButton.frame = CGRectMake(viewWidthCenter - buttonWidth/2, CGRectGetMaxY(self.assignToBarButton.frame) + buttonPadding, buttonWidth, buttonHeight);
    self.assignToStoreButton.frame = CGRectMake(viewWidthCenter - buttonWidth/2, CGRectGetMaxY(self.assignToMuseumButton.frame) + buttonPadding, buttonWidth, buttonHeight);
    
    [self addViewsToView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CategoryButtonHandler

- (void) categoryButtonHandler:(BSCategoryButton *)sender {
    [sender.poi assignToCategory:sender.category];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate didAddCategoryTag:sender];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedResultViewNotification" object:self];
    }];
    
}

@end
