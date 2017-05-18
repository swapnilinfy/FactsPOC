//
//  FactsAPITests.m
//  Facts
//
//  Created by Swapnil Patil on 5/18/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "Constants.h"
#import "FactsManager.h"

@interface FactsAPITests : XCTestCase

@property FactsManager *factsManger;

@end

@implementation FactsAPITests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _factsManger = [[FactsManager alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAPIConnection {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Callback as a API Response"];
    [_factsManger getFactsWithCompletionHandler:^(NSError *error) {
        XCTAssertNil(error, "Error should be nil");
        [expectation fulfill];
    }];
}

- (void)testImageDownload {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Download Image and Save Locally"];
    NSString *imageURL = @"https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg";
    [_factsManger downloadImageFromURL:imageURL
                 withCompletionHandler:^(UIImage *image, NSError *error) {
        XCTAssertNotNil(image, "Image should not be a nil");
        XCTAssertNil(error, "Error should be nil");
        [expectation fulfill];
    }];
}

@end
