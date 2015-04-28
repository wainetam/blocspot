//
//  ResultViewController.m
//  Blocspot
//
//  Created by Waine Tam on 4/28/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

//@property (nonatomic, strong) UIView *resultView;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeftGestureRecognizer;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:self.swipeLeftGestureRecognizer];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
                                           
#pragma mark - Swipe Left to Close
                                           
- (void) leftSwipeHandler:(UISwipeGestureRecognizer *)sender {
    // how to create smooth slide transition
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
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
