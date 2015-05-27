//
//  BSModalViewController.m
//  Blocspot
//
//  Created by Waine Tam on 5/27/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSModalViewController.h"

@interface BSModalViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *tapOutsideModal;

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

- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTapOutsideModal];
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
    // without this, will still be attached to window == bad
    [[[[UIApplication sharedApplication] delegate] window] removeGestureRecognizer:self.tapOutsideModal];
}

- (void)initTapOutsideModal {
    self.tapOutsideModal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOutsideModalHandler:)];
    [self.tapOutsideModal setNumberOfTapsRequired:1];
    self.tapOutsideModal.cancelsTouchesInView = YES;
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
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
