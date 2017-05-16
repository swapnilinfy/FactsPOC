//
//  FactsManager.m
//  Facts
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import <AFNetworking.h>

#import "Constants.h"
#import "FactsManager.h"

@implementation FactsManager

@synthesize facts;

- (void)getCountryInformation {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    AFHTTPResponseSerializer * serializer = [AFHTTPResponseSerializer serializer];
    //Set Custom contenttype as the content type supported by JSON is custom
    serializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    manager.responseSerializer = serializer;
    NSURL *URL = [NSURL URLWithString: serverURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"Error: %@", error);
                                                    } else {
                                                        NSString *iso = [[NSString alloc] initWithData:responseObject encoding:NSISOLatin1StringEncoding];
                                                        NSData *dutf8 = [iso dataUsingEncoding:NSUTF8StringEncoding];
                                                        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:dutf8 options:NSJSONReadingMutableContainers error:nil];
                                                        
                                                    }
                                                }];
    [dataTask resume];
}

@end
