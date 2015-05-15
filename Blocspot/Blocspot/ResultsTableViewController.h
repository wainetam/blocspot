//
//  ResultsTableViewController.h
//  Blocspot
//
//  Created by Waine Tam on 4/12/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultsTableViewCell.h"

@interface ResultsTableViewController : UITableViewController <UISearchBarDelegate, ResultsTableViewCellDelegate>

@property (nonatomic, strong) NSArray *results;
//@property (nonatomic, strong) NSMutableArray *favorites;

@end
