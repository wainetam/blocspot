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
    // without this, will still be attached to window == bad
    [[[[UIApplication sharedApplication] delegate] window] removeGestureRecognizer:self.tapOutsideModal];
}

- (void)viewDidLoad {
    [super viewDidLoad];

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
    
    //QUESTION: why do they all get reset to 0,0 (lose its original frame)

//    self.view.bounds = [[[[UIApplication sharedApplication] delegate] window] bounds];
    self.view.frame = CGRectMake(35, 80, 250, 300);
//    self.view.center = self.presentingViewController.view.center;
    self.view.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.8];
    
//    self.assignToRestaurantButton.bounds = self.view.frame;
    self.assignToRestaurantButton.frame = CGRectMake(35, 50, 150, 30);
//    self.assignToRestaurantButton.center = self.view.center;
//    self.assignToBarButton.bounds = self.view.frame;
    self.assignToBarButton.frame = CGRectMake(35, 90, 150, 30);
//    self.assignToBarButton.center = self.view.center;
    self.assignToMuseumButton.frame = CGRectMake(35, 130, 150, 30);
//    self.assignToMuseumButton.center = self.view.center;
    self.assignToStoreButton.frame = CGRectMake(35, 170, 150, 30);
//    self.assignToStoreButton.center = self.view.center;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
