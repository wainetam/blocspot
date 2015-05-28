//
//  BSCategoryFilterViewController.h
//  Blocspot
//
//  Created by Waine Tam on 5/27/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSCategoryViewController.h"

@class BSCategoryButton;
@class TabBarController;

@protocol FilterDelegate <NSObject>

- (void) didSelectCategoryFilter:(id)sender;

@end

@interface BSCategoryFilterViewController : BSCategoryViewController

@property (nonatomic, strong) id delegate;

@end
