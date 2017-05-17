//
//  FactsViewController.m
//  Facts
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "FactsViewController.h"
#import "FactCollectionViewCell.h"
#import "FactsView.h"
#import "FactsManager.h"
#import "View+MASAdditions.h"

static NSString *factCellIdentifier = @"factcell";

@interface FactsViewController () {
 
    FactsManager *factsManager;
    
    UICollectionView *factsCollectionView;
    UIRefreshControl *refreshControl;
    UIActivityIndicatorView *activityIndicator;
}

@end

@implementation FactsViewController

- (id)init {
    if (self = [super init]) {
        factsManager = [[FactsManager alloc] init];
    }
    return(self);
}

- (void)loadView {
    self.view = [[FactsView alloc] init];
    factsCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    factsCollectionView.delegate = self;
    factsCollectionView.dataSource = self;
    [factsCollectionView registerClass:[FactCollectionViewCell class] forCellWithReuseIdentifier:factCellIdentifier];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(loadData)
             forControlEvents:UIControlEventValueChanged];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;
    
    [self.view addSubview:factsCollectionView];
    [self.view addSubview:activityIndicator];
    
    [factsCollectionView mas_makeConstraints:^(MASConstraintMaker* make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods

- (void)loadData {
    [self.view bringSubviewToFront:activityIndicator];
    [activityIndicator startAnimating];
    [factsManager getFactsWithCompletionHandler:^(NSError *error) {
        if(!error) {
            [factsCollectionView reloadData];
            [activityIndicator stopAnimating];
        }
    }];
}

#pragma mark - UICollectionViewDatasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return factsManager.facts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FactCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:factCellIdentifier
                                                                             forIndexPath:indexPath];
    Fact *fact = [factsManager.facts objectAtIndex:indexPath.row];
    [cell setFact:fact];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath  {
    return CGSizeMake(CGRectGetWidth(collectionView.frame), (CGRectGetHeight(collectionView.frame)/5));
}


@end
