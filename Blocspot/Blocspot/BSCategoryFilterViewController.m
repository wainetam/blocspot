//
//  BSCategoryFilterViewController.m
//  Blocspot
//
//  Created by Waine Tam on 5/27/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSCategoryFilterViewController.h"
#import "BSCategory.h"
#import "BSCategoryButton.h"
#import "DataSource.h"
#import "TabBarController.h"


@interface BSCategoryFilterViewController ()

@end

@implementation BSCategoryFilterViewController

- (id)init {
    self = [super init];
    
    if (self) {
        self.categories = (NSMutableArray *)[[DataSource sharedInstance].categories allKeys];
        self.delegate = self.presentingViewController;
        // QUESTION how to assign delegate if none exists?
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BSCategory *restaurant = [[BSCategory alloc] initWithName:@"restaurant" withColor:[UIColor yellowColor]];

    self.assignToRestaurantButton = [[BSCategoryButton alloc] initWithCategory:restaurant withPOI:nil withTextColor:[UIColor yellowColor]];

    [self.assignToRestaurantButton setTitle:restaurant.name forState:UIControlStateNormal];

    [self.assignToRestaurantButton addTarget:self action:@selector(filterByHandler:) forControlEvents:UIControlEventTouchUpInside];

    // create bar button
    BSCategory *bar = [[BSCategory alloc] initWithName:@"bar" withColor:[UIColor blueColor]];

    self.assignToBarButton = [[BSCategoryButton alloc] initWithCategory:bar withPOI:nil withTextColor:[UIColor blueColor]];

    [self.assignToBarButton setTitle:bar.name forState:UIControlStateNormal];

    [self.assignToBarButton addTarget:self action:@selector(filterByHandler:) forControlEvents:UIControlEventTouchUpInside];

    // create museum button
    BSCategory *museum = [[BSCategory alloc] initWithName:@"museum" withColor:[UIColor redColor]];

    self.assignToMuseumButton = [[BSCategoryButton alloc] initWithCategory:museum withPOI:nil withTextColor:[UIColor redColor]];

    [self.assignToMuseumButton setTitle:museum.name forState:UIControlStateNormal];

    [self.assignToMuseumButton addTarget:self action:@selector(filterByHandler:) forControlEvents:UIControlEventTouchUpInside];

    // create store button
    BSCategory *store = [[BSCategory alloc] initWithName:@"store" withColor:[UIColor greenColor]];

    self.assignToStoreButton = [[BSCategoryButton alloc] initWithCategory:store withPOI:nil withTextColor:[UIColor greenColor]];

    [self.assignToStoreButton setTitle:store.name forState:UIControlStateNormal];

    [self.assignToStoreButton addTarget:self action:@selector(filterByHandler:) forControlEvents:UIControlEventTouchUpInside];

    [self addViewsToView];

    // Do any additional setup after loading the view.
}

- (void) addViewsToView {
    NSMutableArray *views = [@[self.assignToRestaurantButton, self.assignToBarButton, self.assignToMuseumButton, self.assignToStoreButton] mutableCopy];
    for (UIView *view in views) {
        [self.view addSubview:view];
        
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.assignToRestaurantButton.frame = CGRectMake(35, 50, 150, 30);
    self.assignToBarButton.frame = CGRectMake(35, 90, 150, 30);
    self.assignToMuseumButton.frame = CGRectMake(35, 130, 150, 30);
    self.assignToStoreButton.frame = CGRectMake(35, 170, 150, 30);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)filterByHandler:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [self.delegate didSelectCategoryFilter:sender];
        //        [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedResultViewNotification" object:self];
    }];
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
