//
//  FactsManager.h
//  Facts
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactsManager : NSObject

@property(nonatomic, retain) NSArray *facts;

- (void)getFactsWithCompletionHandler:(void (^)(NSError *error))completionHandler;

@end
