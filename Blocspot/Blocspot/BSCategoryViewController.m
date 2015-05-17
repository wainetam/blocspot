//
//  BSCategoryViewController.m
//  Blocspot
//
//  Created by Waine Tam on 5/17/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSCategoryViewController.h"
#import "BSCategory.h"
#import "DataSource.h"

@interface BSCategoryViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *tapOutsideModal;

@end

@implementation BSCategoryViewController

- (id)init {
    self = [super init];
    
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        self.categories = (NSMutableArray *)[[DataSource sharedInstance].categories allKeys];
    }
    
    return self;
}

- (void)loadView {
    [super loadView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[[[UIApplication sharedApplication] delegate] window] addGestureRecognizer:self.tapOutsideModal];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tapOutsideModal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOutsideModalHandler:)];
    [self.tapOutsideModal setNumberOfTapsRequired:1];
    self.tapOutsideModal.cancelsTouchesInView = YES;
    
    // Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.view.center = self.presentingViewController.view.center;
    // QUESTION: WHY is this centered (don't need the above line of code to be centered)
    self.view.bounds = CGRectMake(0, 0, 250, 300);
    self.view.backgroundColor = [UIColor yellowColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tap Gestures

- (void)tapOutsideModalHandler:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint location = [sender locationInView:nil]; // passing nil gives us coordinates in the window
        CGPoint locationInVC = [self.presentingViewController.view convertPoint:location fromView:self.view.window];
        
        if ([self.view pointInside:locationInVC withEvent:nil] == NO) {
            // the tap was outside the VC's view
            NSLog(@"outside the modal");
            if (self.presentingViewController) {
                [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];
            }
        }
    }
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
