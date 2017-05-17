//
//  Fact.m
//  Facts
//
//  Created by Swapnil Patil on 5/16/17.
//  Copyright © 2017 Infosys. All rights reserved.
//

#import "Fact.h"

@implementation Fact

@synthesize factImageURL;
@synthesize factImage;
@synthesize factTitle;
@synthesize factDescription;
@synthesize downloadRequired;

//Define the Mapping of JSON to your Object Model
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"factTitle": @"title",
                                                                  @"factDescription": @"description",
                                                                  @"factImageURL": @"imageHref"
                                                                  }];
}


+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"factTitle"]){
        return NO;
    }
    return YES;
}

@end
