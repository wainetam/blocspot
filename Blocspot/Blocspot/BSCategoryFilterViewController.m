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
#import "FavoritesTableViewController.h"


@interface BSCategoryFilterViewController ()

@end

@implementation BSCategoryFilterViewController

- (id)init {
    self = [super init];
    
    if (self) {
//        self.delegate = (FavoritesTableViewController *)self.presentingViewController;
        // QUESTION how to assign delegate if none exists?
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // create clear filter button
    
    self.clearFilterButton = [[BSButton alloc] init];
    [self.clearFilterButton setTitle:@"Clear Filters" forState:UIControlStateNormal];
    
    [self.clearFilterButton addTarget:self action:@selector(clearFilterHandler:) forControlEvents:UIControlEventTouchUpInside];

}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    self.assignToStoreButton.frame = CGRectMake(viewWidthCenter - buttonWidth/2, CGRectGetMaxY(self.assignToMuseumButton.frame) + buttonPadding, buttonWidth, buttonHeight);
    self.clearFilterButton.frame = self.assignToStoreButton.frame;
    UIButton *lastButton = self.assignToStoreButton;
//    QUESTION setButton characteristics in button object
    self.clearFilterButton.frame = CGRectMake(lastButton.frame.origin.x, CGRectGetMaxY(lastButton.frame) + 10, lastButton.frame.size.width, lastButton.frame.size.height);
    
    [self.view addSubview:self.clearFilterButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelModal:(id)sender {
    
    [super cancelModal:sender];
    
    [((TabBarController *)self.delegate).filterButton setEnabled:YES];

}

#pragma mark - CategoryButtonHandler

- (void) categoryButtonHandler:(BSCategoryButton *)sender {
    [[DataSource sharedInstance] sortResults: [DataSource sharedInstance].favorites byCategory:sender.category completion:^{
        NSLog(@"Completed filter");
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate didFilterByCategory:sender.category];
        }];
    }];
}

#pragma mark - ClearFilterHandler

- (void) clearFilterHandler:(BSButton *)sender {
    [[DataSource sharedInstance] revertSortedResults:[DataSource sharedInstance].sortedResults];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate didClearFilter];
    }];
}

@end
