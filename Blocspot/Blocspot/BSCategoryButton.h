//
//  BSCategoryButton.h
//  Blocspot
//
//  Created by Waine Tam on 5/16/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSButton.h"

@class BSCategory;
@class POI;

@interface BSCategoryButton : BSButton

@property (nonatomic, strong) BSCategory *category;
@property (nonatomic, weak) POI *poi;

//
//+ (CGFloat) width;
//+ (CGFloat) padding;
//+ (CGFloat) height;

- (id) initWithCategory:(BSCategory *)category withPOI:(POI *)poi withTextColor:(UIColor *) color;

@end
