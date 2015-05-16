//
//  ResultViewController.m
//  Blocspot
//
//  Created by Waine Tam on 4/28/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultsTableViewCell.h"
#import "POI.h"
#import "DataSource.h"
#import "BSCategory.h"
#import "BSCategoryButton.h"

@interface ResultViewController ()

//@property (nonatomic, strong) UIView *resultView;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeftGestureRecognizer;
@property (nonatomic, weak) POI *poiResult;
@property (nonatomic, strong) UIView *image;
@property (nonatomic, strong) UIView *map;
@property (nonatomic, strong) UIView *info;
@property (nonatomic, strong) UILabel *headline;
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UITextView *contactInfo;
//@property (nonatomic, strong) UILabel *contactInfo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) BSCategoryButton *assignToCategoryButton;

@property (nonatomic, strong) NSLayoutConstraint *headlineHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *addressHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *contactInfoHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *assignToCategoryButtonHeightConstraint;

@end

static UIFont *lightFont;

@implementation ResultViewController

- (id)initWithTableViewCell:(ResultsTableViewCell *)cell {
    self = [super init];
    
    if(self) {
        self.poiResult = cell.resultItem;
//        self.name = cell.resultItem.name;
//        self.headline = cell.resultItem.headline;
        self.swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandler:)];
        self.swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    }

    return self;
}

- (void)loadView {
    [super loadView];
    
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViews];
    [self addViewsToView];
    [self createConstraints];
    [self.view addGestureRecognizer:self.swipeLeftGestureRecognizer];
    // Do any additional setup after loading the view.

}

- (void) createViews {
    self.image = [UIView new];
    self.headline = [UILabel new];
    self.headline.attributedText = [self headlineStringFrom:self.poiResult];
    self.address = [UILabel new];
    self.address.attributedText = [self addressStringFrom:self.poiResult];
    self.address.numberOfLines = 4;
//    self.contactInfo = [UILabel new];
    self.contactInfo = [UITextView new];
    self.contactInfo.textColor = [UIColor blackColor];

    // addCategory button
    BSCategory *restaurant = [BSCategory new];
    restaurant.name = @"restaurant";
    restaurant.color = [UIColor yellowColor];
    
    self.assignToCategoryButton = [[BSCategoryButton alloc] initWithCategory:restaurant andPOI:self.poiResult];
    [self.assignToCategoryButton setTitle:@"Add to Restaurant Category" forState:UIControlStateNormal];
    
    [self.assignToCategoryButton addTarget:self action:@selector(addCategoryTag:) forControlEvents:UIControlEventTouchUpInside];
    
    self.contactInfo = [UITextView new];

    
//    self.contactInfo.frame.size.height = 60;
//    self.contactInfo.attributedText = [self contactInfoStringFrom:self.poiResult];
//    self.contactInfo.editable = NO;
    self.contactInfo.dataDetectorTypes = UIDataDetectorTypeAll;
    self.contactInfo.backgroundColor = [UIColor whiteColor];
    
//    self.contactInfo.numberOfLines = 2;
    
//    self.url = [UIlabel new];
//    self.url.attributedText = [self urlStringFrom:self.poiResult];
//    self.phoneNumber.attributedText = [self phoneNumberStringFrom:self.poiResult];
//    self.location
//    self.addTofavoriteButton;
    
    NSString *phoneNumber = (NSString *)self.poiResult.phoneNumber != nil ? (NSString *)self.poiResult.phoneNumber : @"";
    
    
    NSString *url = self.poiResult.url != nil ? (NSString *)self.poiResult.url : @"";
//    CLLocation *location = (CLLocation *)mapItem.placemark.location != nil ? (CLLocation *)mapItem.placemark.location : [CLLocation new];
    NSDictionary *addressDict = self.poiResult.addressDict != nil ? (NSDictionary *)self.poiResult.addressDict : @{};
    
    
//    NSArray *mapItemValues = @[name, url, phoneNumber, location, addressDict];
//    
//    NSArray *mapItemKeys = @[@"name", @"url", @"phoneNumber", @"location", @"addressDict"];
}

- (void) addViewsToView {
    NSMutableArray *views = [@[self.headline, self.address, self.contactInfo, self.assignToCategoryButton] mutableCopy];
    for (UIView *view in views) {
        [self.view addSubview:view];
        
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Layout

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    CGFloat heightOfNavBar = self.topLayoutGuide.length;
//    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
//    CGFloat yOffset = heightOfNavBar + statusBarHeight;
    CGFloat yOffset = self.topLayoutGuide.length;
    CGFloat height = self.view.bounds.size.height;
    CGFloat width = self.view.bounds.size.width;
    
    self.view.frame = CGRectMake(0, yOffset, width, height - yOffset);
    
//    self.assignToCategoryButton.frame = CGRectMake(0, 100, 100, 50);
//    self.contactInfo.frame = CGRectMake(0, 60, self.view.bounds.size.width, 200);
    
    UIColor *bgColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:1];
    self.view.backgroundColor = bgColor;
    
}

- (NSAttributedString *)headlineStringFrom:(POI *)resultItem {
    CGFloat headlineFontSize = 18;
    
    NSString *baseString = [NSString stringWithFormat:@"%@", resultItem.name];
    
    NSMutableAttributedString *mutableHeadlineString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:headlineFontSize]}];
    
    //    NSRange headlineRange = [baseString rangeOfString:self.resultItem.name];
    //    [mutableHeadlineString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:headlineFontSize] range:headlineRange];
    //    [mutableHeadlineString addAttribute:NSForegroundColorAttributeName value:linkColor range:headlineRange];
    
    return mutableHeadlineString;
}

- (NSAttributedString *)addressStringFrom:(POI *)resultItem {
    CGFloat headlineFontSize = 16;
    
    NSArray *lines = [resultItem.addressDict objectForKey:@"FormattedAddressLines"];
    NSString *addressString = [lines componentsJoinedByString:@"\n"];
    NSLog(@"Address: %@", addressString);
    NSString *baseString = [NSString stringWithFormat:@"%@", addressString];

    
    NSMutableAttributedString *mutableAddressString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:headlineFontSize]}];
    
    return mutableAddressString;
}

- (NSAttributedString *)contactInfoStringFrom:(POI *)resultItem {
    CGFloat headlineFontSize = 16;

    NSString *urlString = [NSString stringWithFormat:@"%@\n%@", resultItem.phoneNumber, resultItem.url];
    
    NSMutableAttributedString *mutableUrlString = [[NSMutableAttributedString alloc] initWithString:urlString attributes:@{NSFontAttributeName : [lightFont fontWithSize:headlineFontSize]}];
    
    return mutableUrlString;
}

//- (NSAttributedString *)usernameAndCaptionString {
//    CGFloat usernameFontSize = 15;
//    
//    // make a string that says 'username caption text'
//    NSString *baseString = [NSString stringWithFormat:@"%@ %@", self.mediaItem.user.userName, self.mediaItem.caption];
//    
//    // make an attributed string, with the 'username bold'
//    NSMutableAttributedString *mutableUsernameAndCaptionString = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [lightFont fontWithSize:usernameFontSize], NSParagraphStyleAttributeName: paragraphStyle}];
//    
//    NSRange usernameRange = [baseString rangeOfString:self.mediaItem.user.userName];
//    [mutableUsernameAndCaptionString addAttribute:NSFontAttributeName value:[boldFont fontWithSize:usernameFontSize] range:usernameRange];
//    [mutableUsernameAndCaptionString addAttribute:NSForegroundColorAttributeName value:linkColor range:usernameRange];
//    
//    return mutableUsernameAndCaptionString;
//}

#pragma mark - Categories

//- (void) poi:(POI *)poi assignToCategory:(BSCategory *)category {
//    if (![poi hasCategory:category]) {
//        [[DataSource sharedInstance].categories[category.name] addObject:poi];
//        [self addCategoryTag:category toView:self.view];
//        
//        // add to Favorites if haven't already
//        if (![poi isFavorited]) {
//            [poi addToFavorites];
//        }
//        
//    } else {
//        // already added to category X
//    }
//}

- (void) addCategoryTag:(BSCategoryButton *)sender {
    [sender.poi assignToCategory:sender.category];
    
    UILabel *categoryTag = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, 100, 20)];
    // do you call layout subview
    [categoryTag setText:sender.category.name];
    categoryTag.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:categoryTag];
}

#pragma mark - Swipe Left to Close
                                           
- (void) leftSwipeHandler:(UISwipeGestureRecognizer *)sender {
    
    // how to do page slide?
    CATransition *transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    
    //QUESTION: why is presentingVC here UINav?
    ((UINavigationController *)self.presentingViewController).navigationBarHidden = NO;
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Constraints

- (void) createCommonConstraints {
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_headline, _address, _contactInfo, _assignToCategoryButton);
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_headline]-20-|" options:NSLayoutFormatAlignAllTop metrics:nil views:viewDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[_assignToCategoryButton][_headline][_address][_contactInfo]" options:kNilOptions metrics:nil views:viewDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_address]-8-|" options:kNilOptions metrics:nil views:viewDictionary]];
    
    self.assignToCategoryButtonHeightConstraint = [NSLayoutConstraint constraintWithItem:_assignToCategoryButton
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                  constant:20];
    
    self.headlineHeightConstraint = [NSLayoutConstraint constraintWithItem:_headline
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                  constant:20];
    self.addressHeightConstraint = [NSLayoutConstraint constraintWithItem:_address
                                                                 attribute:NSLayoutAttributeHeight
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:nil
                                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                                multiplier:1
                                                                  constant:60];
    self.contactInfoHeightConstraint = [NSLayoutConstraint constraintWithItem:_contactInfo
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1
                                                                 constant:40];
    
    [self.view addConstraints:@[self.headlineHeightConstraint, self.addressHeightConstraint, self.contactInfoHeightConstraint]];
    
}


- (void) createConstraints {
    //    if (isPhone) {
    //        [self createPhoneConstraints];
    //    } else {
    //        [self createPadConstraints];
    //    }
    
    [self createCommonConstraints];
}

@end
