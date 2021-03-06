//
//  FactCollectionViewCell.h
//  Facts
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fact.h"

@interface FactCollectionViewCell : UICollectionViewCell

@property(nonatomic, readonly) UILabel *factTitleLabel;
@property(nonatomic, readonly) UILabel *factDescriptionLabel;
@property(nonatomic, readonly) UIImageView *factImageView;
@property(nonatomic, readonly) UIActivityIndicatorView *activityIndicatorView;

- (void)setFact:(Fact *)fact;

@end
