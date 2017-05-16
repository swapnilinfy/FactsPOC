//
//  FactsViewController.m
//  Facts
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "FactsViewController.h"
#import "FactsView.h"

@interface FactsViewController ()

@end

@implementation FactsViewController

- (id)init {
    if (self = [super init]) {
        self.view = [[FactsView alloc] init];
        //self.view.backgroundColor = [UIColor redColor];
    }
    return(self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// tell UIKit that you are using AutoLayout
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end
