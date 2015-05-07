//
//  ResultViewController.m
//  Blocspot
//
//  Created by Waine Tam on 4/28/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ResultViewController.h"
#import "POI.h"

@interface ResultViewController ()

//@property (nonatomic, strong) UIView *resultView;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeftGestureRecognizer;
@property (nonatomic, weak) POI *poiResult;
@property (nonatomic, strong) UIView *image; // QUESTION: best way to get images? native to MKLocalSearch?
@property (nonatomic, strong) UIView *map;
@property (nonatomic, strong) UIView *info;

@end

@implementation ResultViewController

- (id)initWithTableViewCell:cell {
    self = [super init];
    
    if(self) {
        self.swipeLeftGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeHandler:)];
        self.swipeLeftGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    }

    return self;
}

- (void)loadView {
    [super loadView];
//QUESTION: how to make modal transparent
//    UIColor *whiteBG = [UIColor colorWithWhite:1.0 alpha:.1];
//    self.view.backgroundColor = whiteBG;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createViews];
    [self addViewsToView];
    [self.view addGestureRecognizer:self.swipeLeftGestureRecognizer];
    // Do any additional setup after loading the view.
}

- (void) createViews {
    self.image = [UIView new];
//    self.topView = [UIToolbar new];
//    self.bottomView = [UIToolbar new];
//    self.cropBox = [CropBox new];
//    self.cameraToolbar = [[CameraToolbar alloc] initWithImageNames:@[@"rotate", @"road"]];
//    self.cameraToolbar.delegate = self;
//    UIColor *whiteBG = [UIColor colorWithWhite:1.0 alpha:.15];
//    self.view.backgroundColor = whiteBG;
//    self.topView.barTintColor = whiteBG; // barTintColor is like backgroundColor but it'll be translucent when rendered
//    self.bottomView.barTintColor = whiteBG;
//    self.topView.alpha = 0.5;
//    self.bottomView.alpha = 0.5;
}

- (void) addViewsToView {
    NSMutableArray *views = [@[self.image] mutableCopy];
    //    NSMutableArray *views = [@[self.image, self.info, self.map] mutableCopy];
//    [views addObject:self.cameraToolbar];
    
    for (UIView *view in views) {
        [self.view addSubview:view];
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
    
    NSLog(@"resultView frame origin %f", self.view.frame.origin.y);
    
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

#pragma mark - Swipe Left to Close
                                           
- (void) leftSwipeHandler:(UISwipeGestureRecognizer *)sender {
//    self.presentingViewController.navigationController.navigationBarHidden = NO;
//QUESTION: why is presentingVC here UINav?
    
    
    // QUESTION optimal way to create smooth slide transition?
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

@end
