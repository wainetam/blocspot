//
//  ResultTableViewCell.h
//  Blocspot
//
//  Created by Waine Tam on 4/12/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class POI;
@class DataSource;

// custom delegate
@protocol ResultsTableViewCellDelegate <NSObject>

//- (void) cell:(ResultsTableViewCell *)cell didTapImageView:(UIImageView *)imageView;
//- (void) cell:(MediaTableViewCell *)cell didLongPressImageView:(UIImageView *)imageView;
//- (void) cell:(MediaTableViewCell *)cell didTwoFingerTapImageView:(UIImageView *)imageView;
//- (void) cellDidPressLikeButton:(MediaTableViewCell *)cell;
//- (void) cellWillStartComposingComment:(MediaTableViewCell *)cell;
//- (void) cell:(MediaTableViewCell *)cell didComposeComment:(NSString *)comment;

@end


@interface ResultsTableViewCell : UITableViewCell

@property (nonatomic, weak) id <ResultsTableViewCellDelegate> delegate;
@property (nonatomic, strong) POI *resultItem; // encapsulate from POI

+ (CGFloat)heightForResultItem:(POI *)resultItem width:(CGFloat)width;

- (POI *)resultItem;
// set a new media item
- (void)setResultItem:(POI *)resultItem;

@end
