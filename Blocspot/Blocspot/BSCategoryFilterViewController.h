//
//  BSCategoryFilterViewController.h
//  Blocspot
//
//  Created by Waine Tam on 5/27/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSCategoryViewController.h"

@class BSButton;
@class BSCategoryButton;
@class TabBarController;

@protocol FilterDelegate <NSObject>

- (void) didFilterByCategory:(BSCategory*)category;
- (void) didClearFilter;

@end

@interface BSCategoryFilterViewController : BSCategoryViewController

@property (nonatomic, strong) id delegate; // QUESTION what does dynamic mean?
@property (nonatomic, strong) BSButton *clearFilterButton;

@end
