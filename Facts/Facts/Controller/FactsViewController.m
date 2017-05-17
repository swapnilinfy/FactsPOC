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
#import "Haneke.h"
#import "Constants.h"

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

//This method is required as we dont have a xib or storyboard
- (void)loadView {
    self.view = [[FactsView alloc] init];
    factsCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    factsCollectionView.backgroundColor = [UIColor whiteColor];
    factsCollectionView.delegate = self;
    factsCollectionView.dataSource = self;
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(loadData)
             forControlEvents:UIControlEventValueChanged];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;
    
    [self.view addSubview:factsCollectionView];
    [self.view addSubview:activityIndicator];
    [factsCollectionView addSubview:refreshControl];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [factsCollectionView registerClass:[FactCollectionViewCell class] forCellWithReuseIdentifier:factCellIdentifier];
    self.title = @"FactsPOC";
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [factsCollectionView mas_remakeConstraints:^(MASConstraintMaker* make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsZero);
    }];
    
    [activityIndicator mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(factsCollectionView);
    }];
}

#pragma mark - Custom Methods

- (void)loadData {
    [self.view bringSubviewToFront:activityIndicator];
    [activityIndicator startAnimating];
    [factsManager getFactsWithCompletionHandler:^(NSError *error) {
        if(!error) {
            [factsCollectionView reloadData];
            [activityIndicator stopAnimating];
            [refreshControl endRefreshing];
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
    Fact *fact = [factsManager.facts objectAtIndex:indexPath.row];
    if (fact.downloadRequired || !fact.factImage) {
        //TODO: save in constants file
        return CGSizeMake(200, 150);
    }
    else {
        FactCollectionViewCell *factCell = (FactCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        float heightAdjustment = factCell.factTitleLabel.frame.size.height + factCell.factDescriptionLabel.frame.size.height + (kCellPadding * 3);
        return CGSizeMake(fact.factImage.size.width, heightAdjustment + fact.factImage.size.height);
    }
    
}

//Lodaing the images on demand
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Fact *fact = [factsManager.facts objectAtIndex:indexPath.row];
    FactCollectionViewCell *factCell = (FactCollectionViewCell *)cell;

    if (fact.downloadRequired) {
        [factsManager downloadImageFromURL:fact.factImageURL withCompletionHandler:^(UIImage *image, NSError *error) {
            if (image) {
                fact.factImage = image;
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }
            fact.downloadRequired = false;
        }];
    }
    else {
        if (fact.factImage) {
            factCell.factImageView.image = fact.factImage;
        }
        else {
            factCell.factImageView.image = nil;
        }
    }
}


@end
