//
//  FavoritesTableViewController.h
//  Blocspot
//
//  Created by Waine Tam on 5/15/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTableViewController.h"
#import "BSCategoryFilterViewController.h"

@interface FavoritesTableViewController : BSTableViewController
@property (nonatomic, strong) NSMutableArray* filteredFavoritesArray;

@end
