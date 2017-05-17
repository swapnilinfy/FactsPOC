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
#import "Fact.h"

@implementation FactsManager

@synthesize facts = _facts;

- (id)init {
    self = [super init];
    if (self) {
        _facts = [[NSArray alloc] init];
    }
    return(self);
}

- (void)getFactsWithCompletionHandler:(void (^)(NSError *error))completionHandler {
    
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
                                                    if (!error)  {
                                                        NSString *iso = [[NSString alloc] initWithData:responseObject encoding:NSISOLatin1StringEncoding];
                                                        NSData *dutf8 = [iso dataUsingEncoding:NSUTF8StringEncoding];
                                                        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:dutf8 options:NSJSONReadingMutableContainers error:nil];
                                                        
                                                        NSArray *factsDictionaryArray = [responseDictionary objectForKey:@"rows"];
                                                        NSMutableArray *factsArray = [[NSMutableArray alloc] init];
                                                        NSError *jsonError = nil;
                                                        for(NSDictionary *factDictionary in factsDictionaryArray) {
                                                            Fact *fact = [[Fact alloc] initWithDictionary:factDictionary error:&jsonError];
                                                            if (fact) {
                                                                [factsArray addObject:fact];
                                                            }
                                                        }
                                                        _facts = factsArray;
                                                    }
                                                    
                                                    completionHandler(error);
                                                }];
    [dataTask resume];
}

@end
