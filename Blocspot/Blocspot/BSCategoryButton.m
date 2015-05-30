//
//  BSCategoryButton.m
//  Blocspot
//
//  Created by Waine Tam on 5/16/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSCategory.h"
#import "BSCategoryButton.h"
#import "POI.h"

@implementation BSCategoryButton

- (id) initWithCategory:(BSCategory *)category withPOI:(POI *)poi withTextColor:(UIColor *) color {
    self = [super init];
    
    if(self) {
        self.category = category;
        self.poi = poi;
        [self setTitleColor:color forState:UIControlStateNormal];
        [self setTintColor:color];
        [self.layer setBorderColor:[color CGColor]];
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
