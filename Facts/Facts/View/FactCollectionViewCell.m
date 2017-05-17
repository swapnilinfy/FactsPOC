//
//  FactCollectionViewCell.m
//  Facts
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "FactCollectionViewCell.h"
#import "View+MASAdditions.h"
#import "Constants.h"
#import "Haneke.h"

@implementation FactCollectionViewCell

@synthesize factImageView = _factImageView;
@synthesize factDescriptionLabel = _factDescriptionLabel;
@synthesize factTitleLabel = _factTitleLabel;

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        _factTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _factTitleLabel.textColor = [UIColor blackColor];
        _factTitleLabel.backgroundColor = [UIColor greenColor];
        
        _factDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _factDescriptionLabel.textColor = [UIColor blackColor];
        _factDescriptionLabel.numberOfLines = 3;
        _factDescriptionLabel.backgroundColor = [UIColor blueColor];
        
        _factImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 50)];
        _factImageView.backgroundColor = [UIColor yellowColor];
        
        //self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        //self.contentView.translatesAutoresizingMaskIntoConstraints = YES;
        
        [self addSubview:_factTitleLabel];
        [self addSubview:_factDescriptionLabel];
        [self addSubview:_factImageView];
       
        [self setNeedsUpdateConstraints];
    }
    return(self);
}

- (void)setFact:(Fact *)fact {
    _factTitleLabel.text = fact.factTitle;
    _factDescriptionLabel.text = fact.factDescription;
}

- (void)setFactImage:(NSString *)imageURL {
    [_factImageView hnk_setImageFromURL:[NSURL URLWithString:imageURL] placeholder:nil success:^(UIImage *image) {
        _factImageView.image = image;
    } failure:^(NSError *error) {
        
    }];
}

- (void)updateConstraints {
    
    [_factTitleLabel mas_updateConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(self.mas_top).with.offset(kCellPadding);
        make.left.equalTo(self.mas_left).with.offset(kCellPadding);
        make.bottom.equalTo(_factDescriptionLabel.mas_top).with.offset(-kCellPadding);
        make.right.equalTo(self.mas_right).with.offset(-kCellPadding);
        make.height.mas_equalTo(30);
    }];
    
    [_factDescriptionLabel mas_updateConstraints:^(MASConstraintMaker* make) {
        //make.top.equalTo(_factTitleLabel.mas_bottom).with.offset(kCellPadding);
        make.left.equalTo(self.mas_left).with.offset(kCellPadding);
        make.bottom.equalTo(_factImageView.mas_top).with.offset(-kCellPadding);
        make.right.equalTo(self.mas_right).with.offset(-kCellPadding);
        make.height.mas_equalTo(60);
    }];

    [_factImageView mas_updateConstraints:^(MASConstraintMaker* make) {
        //make.top.equalTo(self.superview.mas_top).with.offset(kCellPadding);
        make.left.equalTo(self.mas_left).with.offset(kCellPadding);
        make.bottom.equalTo(self.mas_bottom).with.offset(-kCellPadding);
        make.right.equalTo(self.mas_right).with.offset(-kCellPadding);
    }];
    
    [super updateConstraints];
}

@end
