//
//  BSCategoryViewController.h
//  Blocspot
//
//  Created by Waine Tam on 5/17/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSCategory;
@class BSCategoryButton;
@class ResultViewController;
@class POI;

@protocol BSCategoryViewControllerDelegate <NSObject>

@required
- (void) categoryViewControllerDismissed:(id)sender;

@end

@interface BSCategoryViewController : UIViewController

@property (nonatomic, weak) NSMutableArray *categories;
@property (nonatomic, weak) POI *poiResult;
@property (nonatomic, strong) BSCategoryButton *assignToRestaurantButton;
@property (nonatomic, strong) BSCategoryButton *assignToBarButton;
@property (nonatomic, strong) BSCategoryButton *assignToMuseumButton;
@property (nonatomic, strong) BSCategoryButton *assignToStoreButton;

@property (nonatomic, strong) ResultViewController *delegate;

@end
