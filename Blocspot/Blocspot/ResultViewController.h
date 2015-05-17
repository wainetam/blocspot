//
//  ResultViewController.h
//  Blocspot
//
//  Created by Waine Tam on 4/28/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ResultsTableViewCell;
@class POI;

@interface ResultViewController : UIViewController

@property (nonatomic, weak) POI *poiResult;

- (id)initWithTableViewCell:(ResultsTableViewCell *)cell;

@end
