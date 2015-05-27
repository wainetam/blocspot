//
//  BSCategory.h
//  Blocspot
//
//  Created by Waine Tam on 5/15/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BSCategory : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;
//@property (nonatomic, strong) NSDictionary *classification;

+ (UIImage *)imageLookupByCategoryName:(NSString *)name;

- (instancetype)initWithName:(NSString *)name withColor:(UIColor *)color;

@end