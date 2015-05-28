//
//  BSCategory.m
//  Blocspot
//
//  Created by Waine Tam on 5/15/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSCategory.h"

@implementation BSCategory

+ (UIImage *)imageLookupByCategoryName:(NSString *)name {
    if ([name isEqualToString: @"restaurant"]) {
        return [UIImage imageNamed:@"food-64.png"];
    } else if ([name isEqualToString: @"museum"]) {
        return [UIImage imageNamed:@"art-64.png"];
    } else if ([name isEqualToString: @"store"]) {
        return [UIImage imageNamed:@"shopping-64.png"];
    } else if ([name isEqualToString: @"bar"]) {
        return [UIImage imageNamed:@"wine-64.png"];
    } else {
        return nil;
    }
}

- (id)initWithName:(NSString *)name withColor:(UIColor *)color {
    self = [super init];
    
    if (self) {
        self.name = name;
        self.color = color;
    }
    return self;
}

@end
