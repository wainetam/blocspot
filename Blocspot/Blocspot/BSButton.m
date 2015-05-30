//
//  BSButton.m
//  Blocspot
//
//  Created by Waine Tam on 5/30/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSButton.h"

@implementation BSButton

- (id) init {
    self = [super init];
    
    if(self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTintColor:[UIColor whiteColor]];
        [self setTitleEdgeInsets:UIEdgeInsetsZero];
        [self.layer setBorderWidth:2.0];
        [self.layer setCornerRadius:4.0];
        [self.layer setBorderColor:[[UIColor whiteColor] CGColor]];
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
