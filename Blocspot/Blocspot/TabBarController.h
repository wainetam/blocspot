//
//  TabBarController.h
//  Blocspot
//
//  Created by Waine Tam on 4/21/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Search.h"
#import "ResultViewController.h"
#import "BSCategoryFilterViewController.h"

//@class Search;
//QUESTION why need to import Search.h vs just the class to be able to recognize the SearchDelegate

@interface TabBarController : UITabBarController <UITabBarControllerDelegate, SearchDelegate, EditFavoriteDelegate, CategoryFilterDelegate>

@property (nonatomic, strong) UIBarButtonItem *filterButton; // for favorites section
//- (void)didCompleteSearch;

@end
