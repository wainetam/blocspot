//
//  BSCategoryFilterViewController.h
//  Blocspot
//
//  Created by Waine Tam on 5/27/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSModalViewController.h"

@class BSCategoryButton;
@class TabBarController;

@protocol FilterDelegate <NSObject>

- (void) didSelectCategoryFilter:(id)sender;

@end

@interface BSCategoryFilterViewController : BSModalViewController

@property (nonatomic, weak) NSMutableArray *categories;

@property (nonatomic, strong) BSCategoryButton *assignToRestaurantButton;
@property (nonatomic, strong) BSCategoryButton *assignToBarButton;
@property (nonatomic, strong) BSCategoryButton *assignToMuseumButton;
@property (nonatomic, strong) BSCategoryButton *assignToStoreButton;

@property (nonatomic, strong) id delegate;

@end
