//
//  TabBarController.h
//  Blocspot
//
//  Created by Waine Tam on 4/21/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Search.h"
//@class Search;
//QUESTION why need to import Search.h vs just the class to be able to recognize the SearchDelegate

@interface TabBarController : UITabBarController <UITabBarControllerDelegate, SearchDelegate>

//- (void)didCompleteSearch;

@end
