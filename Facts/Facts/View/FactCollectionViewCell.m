//
//  FactCollectionViewCell.m
//  Facts
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "FactCollectionViewCell.h"

@implementation FactCollectionViewCell

@synthesize factImageView = _factImageView;
@synthesize factDescriptionLabel = _factDescriptionLabel;
@synthesize factTitleLabel = _factTitleLabel;

- (void)setFact:(Fact *)fact {
    _factTitleLabel.text = fact.factTitle;
    _factDescriptionLabel.text = fact.factDescription;

}

@end
