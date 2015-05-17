//
//  BSCategoryButton.m
//  Blocspot
//
//  Created by Waine Tam on 5/16/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSCategoryButton.h"
#import "BSCategory.h"
#import "POI.h"

@implementation BSCategoryButton

- (id) initWithCategory:(BSCategory *)category andPOI:(POI *)poi {
    self = [super init];
    
    if(self) {
        self.category = category;
        self.poi = poi;
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