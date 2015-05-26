//
//  BSCategoryViewController.m
//  Blocspot
//
//  Created by Waine Tam on 5/17/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BSCategory.h"
#import "BSCategoryButton.h"
#import "BSCategoryViewController.h"
#import "DataSource.h"
#import "ResultViewController.h"
#import "POI.h"


@interface BSCategoryViewController ()

@property (nonatomic, strong) UITapGestureRecognizer *tapOutsideModal;
//@property (nonatomic, weak) POI *poiResult;

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
//    [self.presentingViewController.view addGestureRecognizer:self.tapOutsideModal];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // without this, will still be attached to window == bad
    [[[[UIApplication sharedApplication] delegate] window] removeGestureRecognizer:self.tapOutsideModal];
//    [self.presentingViewController.view removeGestureRecognizer:self.tapOutsideModal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tapOutsideModal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOutsideModalHandler:)];
    [self.tapOutsideModal setNumberOfTapsRequired:1];
    self.tapOutsideModal.cancelsTouchesInView = YES;
    
    // create restaurant button
    BSCategory *restaurant = [[BSCategory alloc] initWithName:@"restaurant" withColor:[UIColor yellowColor]];
    
    self.assignToRestaurantButton = [[BSCategoryButton alloc] initWithCategory:restaurant withPOI:self.poiResult withTextColor:[UIColor yellowColor]];
    
    [self.assignToRestaurantButton setTitle:restaurant.name forState:UIControlStateNormal];
    
    [self.assignToRestaurantButton addTarget:self action:@selector(addCategoryTagHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    // create bar button
    BSCategory *bar = [[BSCategory alloc] initWithName:@"bar" withColor:[UIColor blueColor]];
    
    self.assignToBarButton = [[BSCategoryButton alloc] initWithCategory:bar withPOI:self.poiResult withTextColor:[UIColor blueColor]];
    
    [self.assignToBarButton setTitle:bar.name forState:UIControlStateNormal];
    
    [self.assignToBarButton addTarget:self action:@selector(addCategoryTagHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    // create museum button
    BSCategory *museum = [[BSCategory alloc] initWithName:@"museum" withColor:[UIColor redColor]];
    
    self.assignToMuseumButton = [[BSCategoryButton alloc] initWithCategory:museum withPOI:self.poiResult withTextColor:[UIColor redColor]];
    
    [self.assignToMuseumButton setTitle:museum.name forState:UIControlStateNormal];
    
    [self.assignToMuseumButton addTarget:self action:@selector(addCategoryTagHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    // create store button
    BSCategory *store = [[BSCategory alloc] initWithName:@"store" withColor:[UIColor greenColor]];
    
    self.assignToStoreButton = [[BSCategoryButton alloc] initWithCategory:store withPOI:self.poiResult withTextColor:[UIColor greenColor]];
    
    [self.assignToStoreButton setTitle:store.name forState:UIControlStateNormal];
    
    [self.assignToStoreButton addTarget:self action:@selector(addCategoryTagHandler:) forControlEvents:UIControlEventTouchUpInside];

    [self addViewsToView];
    
    // Do any additional setup after loading the view.
}

- (void) addViewsToView {
    NSMutableArray *views = [@[self.assignToRestaurantButton, self.assignToBarButton, self.assignToMuseumButton, self.assignToStoreButton] mutableCopy];
    for (UIView *view in views) {
        [self.view addSubview:view];
        
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    // QUESTION: WHY is this centered (don't need the above line of code to be centered)
//    self.view.bounds = self.view.window.bounds;
    self.view.frame = CGRectMake(35, 80, 250, 300);
//    self.view.center = self.presentingViewController.view.center;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.assignToRestaurantButton.frame = CGRectMake(0, 50, 250, 20);
    self.assignToBarButton.frame = CGRectMake(0, 75, 250, 20);
    self.assignToMuseumButton.frame = CGRectMake(0, 100, 250, 20);
    self.assignToStoreButton.frame = CGRectMake(0, 125, 250, 20);
//QUESTION: why do they all get reset to 0,0
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
                [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
                
//                [self dismissViewControllerAnimated:NO completion:nil];
            }
        }
    }
}

#pragma mark - Add to Category

- (void) addCategoryTagHandler:(BSCategoryButton *)sender {
    [sender.poi assignToCategory:sender.category];
    
//    UILabel *categoryTag = [[UILabel alloc] initWithFrame:CGRectMake(20, 400, self.view.bounds.size.width, 20)];
//    // do you call layout subview
//    [categoryTag setText:sender.category.name];
//    categoryTag.backgroundColor = [UIColor whiteColor];
    
    // add delegate to result view controller
    
    
//    [self.presentingViewController.view addSubview:categoryTag];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.delegate didAddCategoryTag:sender];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"EditedResultViewNotification" object:self];
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
