//
//  Fact.m
//  Facts
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "Fact.h"

@implementation Fact

//Define the Mapping of JSON to your Object Model
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"title": @"factTitle",
                                                                  @"description": @"factDescription",
                                                                  @"imageHref": @"factImageURL"
                                                                  }];
}


+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
