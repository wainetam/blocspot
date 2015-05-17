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

@interface BSCategoryViewController : UIViewController

@property (nonatomic, weak) NSMutableArray *categories;
@property (nonatomic, strong) BSCategoryButton *assignToCategoryButton;

@end
