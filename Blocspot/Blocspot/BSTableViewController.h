//
//  BSTableViewController.h
//  Blocspot
//
//  Created by Waine Tam on 5/16/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultsTableViewCell.h"
#import "MapViewController.h"

@interface BSTableViewController : UITableViewController <UISearchBarDelegate, ResultsTableViewCellDelegate, TableViewRowDelegate>

//@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSString *resultsKeyPath;
@property (nonatomic, strong) NSString *secondResultsKeyPath;

- (void)refreshTableData:(id)sender;
- (NSArray*) results;

@end
