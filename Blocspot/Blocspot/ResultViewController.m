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

@interface ResultViewController ()

//@property (nonatomic, strong) UIView *resultView;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeftGestureRecognizer;
@property (nonatomic, weak) POI *poiResult;
@property (nonatomic, strong) UIView *image;
@property (nonatomic, strong) UIView *map;
@property (nonatomic, strong) UIView *info;
@property (nonatomic, strong) UILabel *headline;
@property (nonatomic, strong) UILabel *address;
//@property (nonatomic, strong) UITextView *contactInfo;
@property (nonatomic, strong) UILabel *contactInfo;
@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSLayoutConstraint *headlineHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *addressHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *contactInfoHeightConstraint;

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
    self.contactInfo = [UILabel new];
//QUESTION: UILabel vs TextView; also constraints are wrong
//    self.contactInfo = [UITextView new];
//    [self.contactInfo setFrame:CGRectMake(0, 60, self.view.bounds.size.width, 200)];
//    self.contactInfo.frame.size.height = 60;
    self.contactInfo.attributedText = [self contactInfoStringFrom:self.poiResult];
//    self.contactInfo.editable = NO;
//    self.contactInfo.dataDetectorTypes = UIDataDetectorTypeAll;
    
    self.contactInfo.numberOfLines = 2;
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

    
    
//    self.topView = [UIToolbar new];
//    self.bottomView = [UIToolbar new];
//    self.cropBox = [CropBox new];
//    self.cameraToolbar = [[CameraToolbar alloc] initWithImageNames:@[@"rotate", @"road"]];
//    self.cameraToolbar.delegate = self;
//    self.topView.barTintColor = whiteBG; // barTintColor is like backgroundColor but it'll be translucent when rendered
//    self.bottomView.barTintColor = whiteBG;
//    self.topView.alpha = 0.5;
//    self.bottomView.alpha = 0.5;
}

- (void) addViewsToView {
    NSMutableArray *views = [@[self.headline, self.address, self.contactInfo] mutableCopy];
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
    
    UIColor *bgColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:1];
    self.view.backgroundColor = bgColor;
    
//    NSLog(@"resultView frame origin %f", self.view.frame.origin.y);
    
    
    
//    CGFloat width = CGRectGetWidth(self.view.bounds);
//    self.topView.frame = CGRectMake(0, self.topLayoutGuide.length, width, 44);
//    
//    CGFloat yOriginOfBottomView = CGRectGetMaxY(self.topView.frame) + width;
//    CGFloat heightOfBottomView = CGRectGetHeight(self.view.frame) - yOriginOfBottomView;
//    self.bottomView.frame = CGRectMake(0, yOriginOfBottomView, width, heightOfBottomView);
//    
//    self.cropBox.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), width, width);
//    self.imagePreview.frame = self.view.bounds;
//    self.captureVideoPreviewLayer.frame = self.imagePreview.bounds;
//    
//    CGFloat cameraToolbarHeight = 100;
//    self.cameraToolbar.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - cameraToolbarHeight, width, cameraToolbarHeight);
    
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
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(_headline, _address, _contactInfo);
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_headline]-20-|" options:NSLayoutFormatAlignAllTop metrics:nil views:viewDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_headline][_address]-5-[_contactInfo]|" options:kNilOptions metrics:nil views:viewDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_address]-8-|" options:kNilOptions metrics:nil views:viewDictionary]];
    
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
