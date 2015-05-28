//
//  BSTableViewController.h
//  Blocspot
//
//  Created by Waine Tam on 5/16/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultsTableViewCell.h"

@interface BSTableViewController : UITableViewController <UISearchBarDelegate, ResultsTableViewCellDelegate>

//@property (nonatomic, strong) NSArray *results;
@property (nonatomic, strong) NSString *resultsKeyPath;

- (void)refreshTableData:(id)sender;
- (NSArray*) results;

@end
