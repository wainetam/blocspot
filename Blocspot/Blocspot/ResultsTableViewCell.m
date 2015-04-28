//
//  ResultTableViewCell.m
//  Blocspot
//
//  Created by Waine Tam on 4/12/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ResultsTableViewCell.h"
#import "POI.h"
#import "DataSource.h"

@interface ResultsTableViewCell ()

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UILabel *headline;
@property (nonatomic, strong) UILabel *note;
@property (nonatomic, strong) UILabel *distance;
@property (nonatomic, assign) BOOL visited;
@property (nonatomic, strong) UIImageView *visitedImage;
@property (nonatomic, strong) UILabel *category;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;

@property (nonatomic, strong) NSLayoutConstraint *headlineHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *addressHeightConstraint;

@end

static UIFont *lightFont;
static UIFont *boldFont;
static UIColor *usernameLabelGray;
static UIColor *commentLabelGray;
static UIColor *linkColor;
static NSParagraphStyle *paragraphStyle;

@implementation ResultsTableViewCell

+ (void)load {
    
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    usernameLabelGray = [UIColor colorWithRed:1 green:1 blue:1 alpha:1]; // #fff
    commentLabelGray = [UIColor colorWithRed:1 green:1 blue:1 alpha:1]; // #fff
    linkColor = [UIColor colorWithRed:0.345 green:0.314 blue:0.427 alpha:1]; // #58506d
    
    // not sure what this all is ha
    NSMutableParagraphStyle *mutableParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    mutableParagraphStyle.headIndent = 20.0;
    mutableParagraphStyle.firstLineHeadIndent = 20.0;
    mutableParagraphStyle.tailIndent = -20.0;
    mutableParagraphStyle.paragraphSpacingBefore = 5;
    mutableParagraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    paragraphStyle = mutableParagraphStyle;
}

+ (CGFloat)heightForResultItem:(POI *)resultItem width:(CGFloat)width {
    // make a cell
    ResultsTableViewCell *layoutCell = [[ResultsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"layoutCell"];
    
    layoutCell.resultItem = resultItem;
    
//    layoutCell.frame = CGRectMake(0, 0, width, CGRectGetHeight(layoutCell.frame));
    layoutCell.frame = CGRectMake(0, 0, width, 100);
    [layoutCell setNeedsLayout];
    
    [layoutCell layoutIfNeeded];
    
//    return CGRectGetMaxY(layoutCell.contentView.frame);
    return 150;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // initialization code
        self.visitedImage = [[UIImageView alloc] init];
        self.visitedImage.userInteractionEnabled = YES;
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFired:)];
        self.tapGestureRecognizer.delegate = self;
        [self.visitedImage addGestureRecognizer:self.tapGestureRecognizer];
        
        self.headline = [[UILabel alloc] init];
        self.headline.numberOfLines = 1;
        self.note = [[UILabel alloc] init];
        self.note.numberOfLines = 0;
        self.distance = [[UILabel alloc] init];
        self.address = [[UILabel alloc] init];
//        self.category = ""; // add category
        self.visited = NO;
        
        // QUESTION how to change attributes of POI?
//        
        for (UIView *view in @[self.headline, self.address]) {
            [self.contentView addSubview:view];
            view.translatesAutoresizingMaskIntoConstraints = NO; // QUESTION: should this be yes?
        }
        
        [self createConstraints];
    }
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setResultItem:(POI *)resultItem {
    _resultItem = resultItem;
//    self.visited = _resultItem.visited;
    self.headline.attributedText = [self headlineString];
    self.address.attributedText = [self addressString];
    
//    self.note = _poi.note;
//    self.distance = _poi.distance;
//    self.category = _poi.category;
}

- (NSAttributedString *)headlineString {
    CGFloat headlineFontSize = 15;
    
    NSString *baseString = [NSString stringWithFormat:@"%@", self.resultItem.name];
    
    NSMutableAttributedString *mutableHeadlineString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:headlineFontSize]}];
    
//    NSRange headlineRange = [baseString rangeOfString:self.resultItem.name];
//    [mutableHeadlineString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:headlineFontSize] range:headlineRange];
//    [mutableHeadlineString addAttribute:NSForegroundColorAttributeName value:linkColor range:headlineRange];
    
    return mutableHeadlineString;
}

- (NSAttributedString *)addressString {
    CGFloat headlineFontSize = 13;
    
    NSString *baseString = [NSString stringWithFormat:@"%@", self.resultItem.addressDict[@"Street"]];
    
    NSMutableAttributedString *mutableAddressString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:headlineFontSize]}];
    
    return mutableAddressString;
}

#pragma mark - Constraints

- (void) createConstraints {
//    if (isPhone) {
//        [self createPhoneConstraints];
//    } else {
//        [self createPadConstraints];
//    }
    
    [self createCommonConstraints];
}

- (void) createPhoneConstraints {
    
}

- (void) createPadConstraints {
    
}

- (void) createCommonConstraints {
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_headline, _address);
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_headline]|" options:NSLayoutFormatAlignAllTop metrics:nil views:viewDictionary]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_headline][_address]" options:kNilOptions metrics:nil views:viewDictionary]];
    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_address]|" options:kNilOptions metrics:nil views:viewDictionary]];
    
    self.headlineHeightConstraint = [NSLayoutConstraint constraintWithItem:_headline
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                  constant:50];
    
    self.addressHeightConstraint = [NSLayoutConstraint constraintWithItem:_address
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1
                                                                    constant:50];
    
//    self.visitedHeightConstraint = [NSLayoutConstraint constraintWithItem:_visited
//                                                                  attribute:NSLayoutAttributeHeight
//                                                                  relatedBy:NSLayoutRelationEqual
//                                                                     toItem:nil
//                                                                  attribute:NSLayoutAttributeNotAnAttribute
//                                                                 multiplier:1
//                                                                   constant:38];
    
    [self.contentView addConstraints:@[self.headlineHeightConstraint, self.addressHeightConstraint]];
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
//    // before layout, calculate the intrinsic size of the labels (the size they 'want' to be), and add 20 to the height
//    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.bounds), CGFLOAT_MAX);
//    CGSize usernameLabelSize = [self.usernameAndCaptionLabel sizeThatFits:maxSize];
//    CGSize commentLabelSize = [self.commentLabel sizeThatFits:maxSize];
//    usernameLabelSize.width = [UIScreen mainScreen].bounds.size.width;
//    
//    //    self.usernameAndCaptionLabelWidthConstraint.constant = maxSize.width;
//    self.usernameAndCaptionLabelHeightConstraint.constant = usernameLabelSize.height + 20;
//    self.likeCountHeightConstraint.constant = 38;
//    self.likeButtonHeightConstraint.constant = 38;
//    
//    self.commentLabelHeightConstraint.constant = commentLabelSize.height + 20;
//    //    self.commentLabelWidthConstraint.constant = CGRectGetWidth(self.contentView.bounds);
//    
//    // section below moved from setMediaItem
//    if (_mediaItem.image) {
//        if (isPhone) {
//            self.imageHeightConstraint.constant = self.mediaItem.image.size.height / self.mediaItem.image.size.width * CGRectGetWidth(self.contentView.bounds);
//        } else {
//            //        NSLog(@"Content View bounds width %f", CGRectGetWidth(self.contentView.bounds));
//            //        self.imageHeightConstraint.constant = CGRectGetWidth(self.contentView.bounds);
//            self.imageHeightConstraint.constant = 320;
//        }
//    } else {
//        self.imageHeightConstraint.constant = 0;
//    }
//    
//    // hide the line between cells
//    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, CGRectGetWidth(self.bounds));
}



#pragma mark - Visited Toggle

- (void) tapFired:(UITapGestureRecognizer *)sender {
    self.visited = !self.visited;
//    [self.delegate cell:self didTapImageView:self.visitedImage];
}

@end
