//
//  BSCategoryButton.h
//  Blocspot
//
//  Created by Waine Tam on 5/16/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSCategory;
@class POI;

@interface BSCategoryButton : UIButton

@property (nonatomic, strong) BSCategory *category;
@property (nonatomic, weak) POI *poi;

- (id) initWithCategory:(BSCategory *)category withPOI:(POI *)poi withTextColor:(UIColor *) color;

@end
