//
//  FactsAPITests.m
//  Facts
//
//  Created by Swapnil Patil on 5/18/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AFNetworking.h>

#import "Constants.h"

@interface FactsAPITests : XCTestCase

@end

@implementation FactsAPITests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAPIConnection {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Callback as a API Response"];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer serializer];
    //Set Custom contenttype as the content type supported by JSON is custom
    serializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    manager.responseSerializer = serializer;
    NSURL *URL = [NSURL URLWithString: kServerURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                    //Basic test for data
                                                    XCTAssertNotNil(responseObject, "Data should not be nil");
                                                    XCTAssertNil(error, "Error should be nil");
                                                    
                                                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                        XCTAssertEqual(httpResponse.statusCode, 200, @"HTTP response status code should be 200");
                                                        XCTAssertEqualObjects(httpResponse.URL.absoluteString, URL.absoluteString, @"HTTP response URL should be equal to original URL");
                                                        XCTAssertEqualObjects(httpResponse.MIMEType, @"text/plain", @"HTTP response content type should be text/plain");
                                                    } else {
                                                        XCTFail(@"Response was not NSHTTPURLResponse");
                                                    }
                                                    
                                                    [expectation fulfill];
                                                }];
    [dataTask resume];
    
    [self waitForExpectationsWithTimeout:dataTask.originalRequest.timeoutInterval handler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        [dataTask cancel];
    }];
}

@end
