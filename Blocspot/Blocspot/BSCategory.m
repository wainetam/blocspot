//
//  BSCategory.m
//  Blocspot
//
//  Created by Waine Tam on 5/15/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSCategory.h"

@implementation BSCategory

- (id)initWithName:(NSString *)name withColor:(UIColor *)color {
    self = [super init];
    
    if (self) {
        self.name = name;
        self.color = color;
    }
    return self;
}

@end
