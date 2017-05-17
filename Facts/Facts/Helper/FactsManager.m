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
                                                                fact.downloadRequired = YES;
                                                                [factsArray addObject:fact];
                                                            }
                                                        }
                                                        _facts = factsArray;
                                                    }
                                                    
                                                    completionHandler(error);
                                                }];
    [dataTask resume];
}

- (void)downloadImageFromURL:(NSString *)urlString
       withCompletionHandler:(void (^)(UIImage *image, NSError *error))completionHandler {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        UIImage *image = nil;
        if (!error)  {
            image = [UIImage imageWithContentsOfFile:[filePath path]];
        }
        completionHandler(image, error);
    }];
    
    [downloadTask resume];

}

@end
