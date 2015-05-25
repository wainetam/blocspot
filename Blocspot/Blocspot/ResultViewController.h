//
//  ResultViewController.h
//  Blocspot
//
//  Created by Waine Tam on 4/28/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSCategoryViewController.h"

@class ResultsTableViewCell;
@class POI;

@interface ResultViewController : UIViewController <BSCategoryViewControllerDelegate>

@property (nonatomic, weak) POI *poiResult;

- (id)initWithTableViewCell:(ResultsTableViewCell *)cell;

- (void)refreshView:(id)sender;

@end
