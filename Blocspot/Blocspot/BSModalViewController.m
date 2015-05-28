//
//  BSModalViewController.m
//  Blocspot
//
//  Created by Waine Tam on 5/27/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSModalViewController.h"

@interface BSModalViewController ()

@property (nonatomic, strong) UIButton* cancelButton;

@end

@implementation BSModalViewController

- (id)init {
    self = [super init];
    
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [[[[UIApplication sharedApplication] delegate] window] addGestureRecognizer:self.tapOutsideModal];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    self.view.frame = CGRectMake(0, 0, 250, 300);
//    self.view.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2, 240);// for center
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    self.view.bounds = [[UIScreen mainScreen] bounds];
    self.view.frame = CGRectMake(0, 0, width, height);
    
//    [self layoutCategoryButtons];

    self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    
    UIImage *cancelImage = [[UIImage imageNamed:@"letter-64"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *cancelImageView = [[UIImageView alloc] initWithImage:cancelImage];
    [cancelImageView setTintColor:[UIColor whiteColor]];
    
    self.cancelButton.frame = CGRectMake(280.0, 24.0, 25.0, 25.0);
    [self.cancelButton setBackgroundImage:cancelImageView.image forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelModal:) forControlEvents:UIControlEventTouchUpInside];
    
    // for each subview
//    self.cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.cancelButton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)cancelModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)layoutCategoryButtons {
    
    
//    self.fbLoginButton.frame = CGRectMake(35, 100, 250, 40);
//    self.googleLoginButton.frame = CGRectMake(35, 160, 250, 40);
//    
//    for (UIView *view in @[self.fbLoginButton, self.googleLoginButton]) {
//        [self.view addSubview:view];
//        
//        view.translatesAutoresizingMaskIntoConstraints = NO;
//    }
}

//
//- (void)initTapOutsideModal {
//    self.tapOutsideModal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOutsideModalHandler:)];
//    [self.tapOutsideModal setNumberOfTapsRequired:1];
//    self.tapOutsideModal.cancelsTouchesInView = YES;
//}

//
//#pragma mark - Tap Gestures
//
//- (void)tapOutsideModalHandler:(UITapGestureRecognizer *)sender {
//    if (sender.state == UIGestureRecognizerStateEnded) {
//        CGPoint location = [sender locationInView:nil]; // passing nil gives us coordinates in the window
//        CGPoint locationInVC = [self.presentingViewController.view convertPoint:location fromView:self.view.window];
//        
//        if ([self.view pointInside:locationInVC withEvent:nil] == NO) {
//            // the tap was outside the VC's view
//            NSLog(@"outside the modal");
//            if (self.presentingViewController) {
//                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//            }
//        }
//    }
//}

@end

