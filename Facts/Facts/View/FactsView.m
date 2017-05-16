//
//  FactsView.m
//  Facts
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "FactsView.h"
#import "View+MASAdditions.h"


@implementation FactsView

//- (id)init {
//    self = [super init];
//    if (self) {}
//    return(self);
//}


- (void)updateConstraints {
    [self mas_makeConstraints:^(MASConstraintMaker* make) {
        make.edges.equalTo(self.superview).with.insets(UIEdgeInsetsZero);
    }];
    [super updateConstraints];
}


@end
