//
//  FactsTests.m
//  FactsTests
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FactsViewController.h"

@interface FactsTests : XCTestCase

@property FactsViewController *factsViewController;

@end

@implementation FactsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _factsViewController = [[FactsViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testViewController {
    
    XCTAssertNotNil(_factsViewController, @"ViewController should not be a nil");
    
    //Checking for views added programtically
    XCTAssertNotNil(_factsViewController.view, @"ViewController View should not be a nil");
    NSArray *subviews = [_factsViewController.view subviews];
    UICollectionView *collectionView = nil;
    for (UIView *view in subviews) {
        if (view.class == [UICollectionView class]) {
            collectionView = (UICollectionView *)view;
            break;
        }
    }
    XCTAssertNotNil(collectionView, @"CollectionView should not be a nil");
}

@end
