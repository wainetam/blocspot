//
//  FavoritesTableViewController.h
//  Blocspot
//
//  Created by Waine Tam on 5/15/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultsTableViewCell.h"

@interface FavoritesTableViewController : UITableViewController <UISearchBarDelegate, ResultsTableViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *results;
//@property (nonatomic, strong) NSMutableArray *favorites;

@end
